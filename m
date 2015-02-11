From: Pavel Machek <pavel@ucw.cz>
Subject: Voice calls working on N900 (*) (was Re: N900 modem support in
 3.18-rc1)
Date: Wed, 11 Feb 2015 19:32:28 +0100
Message-ID: <20150211183228.GB29636@amd>
References: <20141104205117.GA17606@amd>
 <20141106180335.GA21513@earth.universe>
 <20141106225005.GA14002@amd>
 <201411070001.46481@pali>
 <545C6F14.8050303@gmail.com>
 <20141113162420.GB8512@xo-6d-61-c0.localdomain>
 <5465A977.4030605@gmail.com>
 <20141114172008.GB12250@earth.universe>
 <54665E02.8050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54665E02.8050108@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Pali Roh?r <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, Sakari Ailus <sakari.ailus@iki.fi>, ian.molton@facebook.com
List-Id: linux-omap@vger.kernel.org

Hi!

(*) for low values of working.

Ok, so I got voice on n900 to work on 3.19-n900 tree.. Quality of incoming
voice is reasonable, quality of outgoing voice not so, I was told.

So, you need patched kernel (pali's n900 tree) ofono etc, plus I'm
using ofone python script to control the modem, plus you need
libcmtspeechdata. I have this version:

commit 7f8f3ce357513e4849e1bf6d657980a514529c1a
Author: Kai Vehmanen <kai.vehmanen@nokia.com>
Date:   Tue Mar 8 13:46:48 2011 +0200

    cmtspeech_msgs: fix compiler warning

    Add parenthesis to make the code more readable and to kill a
    compiler
        warning.

    Signed-off-by: Kai Vehmanen <kai.vehmanen@nokia.com>

Plus, apply the patch below. I could not get configure (etc) to work
for me, so I build it by hand. cmtspeech_ofono_test can then be used
to route the voice calls (if you feed it with audio data, see the
"run" script).

What is missing:

* right setup of mixers. (I was actually running audio data to my
desktop for some tests). What commandline tools can be used to set up
mixers? I'm using "alsamixer", but it has text ui...

* passing audio data using pipes is really a hack... and periodically
discarding audio data is certainly not a good idea.

Good luck,
								Pavel

diff --git a/mkit b/mkit
new file mode 100755
index 0000000..6fbd216
--- /dev/null
+++ b/mkit
@@ -0,0 +1,15 @@
+build_lib () {
+for a in test_cmtspeech test_cmtspeech_msgs test_ring; do
+    echo $a
+#    gcc cmtspeech_backend_common.c cmtspeech_msgs.c cmtspeech_nokiamodem.c sal_debug.c $a.c -I. -lrt -o $a
+done
+
+for a in cmtspeech_backend_common cmtspeech_msgs cmtspeech_nokiamodem sal_debug; do
+    gcc -fPIC $a.c -c -I. -o $a.o
+done
+ar rcs libcmtspeech.a cmtspeech_backend_common.o cmtspeech_msgs.o cmtspeech_nokiamodem.o sal_debug.o
+}
+
+# build_lib
+gcc -I . -I /usr/include/dbus-1.0/ -I /usr/lib/arm-linux-gnueabi/dbus-1.0/include/ utils/cmtspeech_ofono_test.c -lpthread -lrt libcmtspeech.a /usr/lib/arm-linux-gnueabi/libdbus-1.a -o cmtspeech_ofono_test
+
diff --git a/run b/run
new file mode 100755
index 0000000..8cb1f9a
--- /dev/null
+++ b/run
@@ -0,0 +1,2 @@
+#!/bin/bash
+parec --rate=4000 --latency-msec=100 | ./cmtspeech_ofono_test -a -v | pacat --rate=4000 --latency-msec=100
diff --git a/utils/cmtspeech_ofono_test.c b/utils/cmtspeech_ofono_test.c
index 4a6f080..ffb323f 100644
--- a/utils/cmtspeech_ofono_test.c
+++ b/utils/cmtspeech_ofono_test.c
@@ -48,6 +48,9 @@
 #include <cmtspeech.h>
 #include <dbus/dbus.h>
 
+#include <unistd.h>
+#include <fcntl.h>
+
 struct test_ctx {
   DBusConnection* dbus_conn;
   int dbus_fd;
@@ -55,6 +58,9 @@ struct test_ctx {
   bool call_server_status;
   int verbose;
   cmtspeech_t *cmtspeech;
+  int source_fd;
+  int sink_fd;
+  int data_through;
 };
 
 #define PREFIX "cmtspeech_ofono_test: "
@@ -75,7 +81,7 @@ static dbus_bool_t priv_add_cb(DBusWatch *watch, void *data)
   ctx->dbus_fd = fd;
   ctx->dbus_watch = watch;
 
-  DEBUG(printf(PREFIX "priv_add_cb: socket %d, watch %p (tracking %p).\n",
+  DEBUG(fprintf(stderr, PREFIX "priv_add_cb: socket %d, watch %p (tracking %p).\n",
 	       fd, watch, ctx->dbus_watch));
 
   return TRUE;
@@ -85,7 +91,7 @@ static void priv_remove_cb(DBusWatch *watch, void *data)
 {
   struct test_ctx *ctx = (struct test_ctx*)data;
 
-  DEBUG(printf(PREFIX "priv_remove_cb: (%p).\n", (void*)watch));
+  DEBUG(fprintf(stderr, PREFIX "priv_remove_cb: (%p).\n", (void*)watch));
 
   if (ctx->dbus_watch == watch) {
     ctx->dbus_watch = NULL;
@@ -99,7 +105,7 @@ static void priv_toggled_cb(DBusWatch *watch, void *data)
   dbus_bool_t enabled =
     dbus_watch_get_enabled(watch);
 
-  DEBUG(printf(PREFIX "priv_toggled_cb: (%p) enabled=%d.\n", (void*)watch, enabled));
+  DEBUG(fprintf(stderr, PREFIX "priv_toggled_cb: (%p) enabled=%d.\n", (void*)watch, enabled));
 
   if (ctx->dbus_watch == watch) {
     if (enabled == TRUE)
@@ -132,7 +138,7 @@ DBusConnection *test_dbus_make_connection(struct test_ctx *ctx, DBusBusType dbus
 
   conn = dbus_bus_get(dbus_type, &dbus_error);
   if (dbus_error_is_set(&dbus_error) != TRUE) {
-    DEBUG(printf(PREFIX "Connection established to DBus (%d).\n", (int)dbus_type));
+    DEBUG(fprintf(stderr, PREFIX "Connection established to DBus (%d).\n", (int)dbus_type));
   }
   else {
     fprintf(stderr, PREFIX "ERROR: unable to connect to DBus\n");
@@ -184,6 +190,24 @@ static void test_dbus_release(struct test_ctx *ctx)
   }
 }
 
+static void flush_input(struct test_ctx *ctx)
+{
+  char scratch[10240];
+  int total = 0;
+
+  fprintf(stderr, "Flushing input...\n");
+  if (!ctx->sink_fd)
+    return;
+  while(1) {
+    int num;
+    num = read(ctx->source_fd, scratch, 10240);
+    if (num == -1)
+      break;
+    total += num;
+  }
+  fprintf(stderr, "Flushing input (%d)\n", total);
+}
+
 static bool test_handle_dbus_ofono(struct test_ctx *ctx, DBusMessage *msg)
 {
   const char* property = NULL;
@@ -194,7 +218,7 @@ static bool test_handle_dbus_ofono(struct test_ctx *ctx, DBusMessage *msg)
     dbus_message_get_args(msg, &dbus_error,
 			  DBUS_TYPE_STRING, &property,
 			  DBUS_TYPE_INVALID);
-    DEBUG(printf(PREFIX "received ofono AudioSettings change, params name='%s'\n",
+    DEBUG(fprintf(stderr, PREFIX "received ofono AudioSettings change, params name='%s'\n",
 		 property));
     if (strcmp(property, "Active") == 0) {
       DBusMessageIter i;
@@ -213,7 +237,11 @@ static bool test_handle_dbus_ofono(struct test_ctx *ctx, DBusMessage *msg)
 	  dbus_message_iter_get_basic(&j, &state);
 
 	  if (state != old_state) {
-	    INFO(printf(PREFIX "org.ofono.AudioSettings.Active to %d.\n", state));
+	    INFO(fprintf(stderr, PREFIX "org.ofono.AudioSettings.Active to %d.\n", state));
+	    if (state == 1) {
+	      flush_input(ctx);
+	    }
+	      
 	    cmtspeech_state_change_call_status(ctx->cmtspeech, state);
 	    ctx->call_server_status = state;
 	  }
@@ -238,14 +266,14 @@ static int test_handle_dbus_message(struct test_ctx *ctx, DBusMessage *msg)
   int res = 0;
   const char* dbusif = dbus_message_get_interface(msg);
 
-  DEBUG(printf(PREFIX "got message to if:%s, member:%s.\n",
+  DEBUG(fprintf(stderr, PREFIX "got message to if:%s, member:%s.\n",
 	      dbusif, dbus_message_get_member(msg)));
 
   if (strstr(dbusif, "org.ofono.")) {
     test_handle_dbus_ofono(ctx, msg);
   }
   else
-    INFO(printf(PREFIX "unknown/ignored signal: if=%s, member=%s.\n",
+    INFO(fprintf(stderr, PREFIX "unknown/ignored signal: if=%s, member=%s.\n",
 		dbusif, dbus_message_get_member(msg)));
 
   return res;
@@ -280,6 +308,7 @@ static struct option const opt_tbl[] =
   {
     {"verbose",         0, NULL, 'v'},
     {"help",            0, NULL, 'h'},
+    {"audio",           0, NULL, 'a'},
     {NULL,              0, NULL, 0}
   };
 
@@ -297,13 +326,24 @@ static void priv_parse_options(struct test_ctx *ctx, int argc, char *argv[])
 
   assert(ctx);
 
-  while (res = getopt_long(argc, argv, "hv", opt_tbl, &opt_index), res != -1) {
+  while (res = getopt_long(argc, argv, "hva", opt_tbl, &opt_index), res != -1) {
     switch (res)
       {
 
       case 'v':
 	++ctx->verbose;
-	printf(PREFIX "Increasing verbosity to %d.\n", ctx->verbose);
+	fprintf(stderr, PREFIX "Increasing verbosity to %d.\n", ctx->verbose);
+	break;
+
+      case 'a':
+	fprintf(stderr, "Enabling audio path\n");
+	ctx->source_fd = 0;
+	ctx->sink_fd = 1;
+	ctx->data_through = 0;
+	{
+	  int flags = fcntl(ctx->source_fd, F_GETFL, 0);
+	  fcntl(ctx->source_fd, F_SETFL, flags | O_NONBLOCK);
+	}
 	break;
 
       case 'h':
@@ -317,16 +357,43 @@ static void priv_parse_options(struct test_ctx *ctx, int argc, char *argv[])
 static void test_handle_cmtspeech_data(struct test_ctx *ctx)
 {
   cmtspeech_buffer_t *dlbuf, *ulbuf;
+  char scratch[10240];
   int res = cmtspeech_dl_buffer_acquire(ctx->cmtspeech, &dlbuf);
   if (res == 0) {
-    DEBUG(printf(PREFIX "Received a DL packet (%u bytes).\n", dlbuf->count));
+    DEBUG(fprintf(stderr, PREFIX "Received a DL packet (%u bytes).\n", dlbuf->count));
     if (cmtspeech_protocol_state(ctx->cmtspeech) ==
 	CMTSPEECH_STATE_ACTIVE_DLUL) {
       res = cmtspeech_ul_buffer_acquire(ctx->cmtspeech, &ulbuf);
       if (res == 0) {
 	if (ulbuf->pcount >= dlbuf->pcount) {
-	  DEBUG(printf(PREFIX "Looping DL packet to UL (%u payload bytes).\n", dlbuf->pcount));
-	  memcpy(ulbuf->payload, dlbuf->payload, dlbuf->pcount);
+	  if (ctx->sink_fd) {
+	    int num;
+
+	    memset(ulbuf->payload, 0, ulbuf->pcount);
+	    num = read(ctx->source_fd, ulbuf->payload, ulbuf->pcount);
+	    if (num != dlbuf->pcount) {
+	      fprintf(stderr, "Not enough data on input (%d/%d)\n", num, dlbuf->pcount);
+	    }
+	    ctx->data_through += ulbuf->pcount;
+
+	    if (ctx->data_through > 100000) {
+	      ctx->data_through = 0;
+	      fprintf(stderr, "Draining input\n");
+	      while(1) {
+		num = read(ctx->source_fd, scratch, 10240);
+		fprintf(stderr, "Too much data on input (%d)\n", num);
+		if (num == -1)
+		  break;
+		if (num < 320)
+		  fprintf(stderr, "Too little to drain (%d)\n", num);
+	      }
+	    }
+
+	    write(ctx->sink_fd, dlbuf->payload, dlbuf->pcount);
+	  } else {
+	    DEBUG(fprintf(stderr, PREFIX "Looping DL packet to UL (%u payload bytes).\n", dlbuf->pcount));
+	    memcpy(ulbuf->payload, dlbuf->payload, dlbuf->pcount);
+	  }
 	}
 	cmtspeech_ul_buffer_release(ctx->cmtspeech, ulbuf);
       }
@@ -341,7 +408,7 @@ static int test_handle_cmtspeech_control(struct test_ctx *ctx)
   int state_tr = CMTSPEECH_TR_INVALID;
 
   cmtspeech_read_event(ctx->cmtspeech, &cmtevent);
-  DEBUG(printf(PREFIX "read cmtspeech event %d.\n", cmtevent.msg_type));
+  DEBUG(fprintf(stderr, PREFIX "read cmtspeech event %d.\n", cmtevent.msg_type));
 
   state_tr = cmtspeech_event_to_state_transition(ctx->cmtspeech, &cmtevent);
 
@@ -399,7 +466,7 @@ static int test_mainloop(struct test_ctx *ctx)
 
     pollres = poll(fds, count, -1);
 
-    DEBUG(printf("poll returned %d (count:%d, cmt:%02X, dbus:%02X)\n",
+    DEBUG(fprintf(stderr, "poll returned %d (count:%d, cmt:%02X, dbus:%02X)\n",
 		 pollres, count, fds[cmt].revents, fds[dbus].revents));
 
     if (pollres > 0) {
@@ -454,6 +521,7 @@ int main(int argc, char *argv[])
   struct test_ctx *ctx = &ctx0;
   int res = 0;
 
+  fprintf(stderr, "NFS sucks, version 0.0.1\n");
   priv_setup_signals();
 
   ctx->dbus_conn = NULL;
@@ -480,14 +548,14 @@ int main(int argc, char *argv[])
     return -1;
   }
 
-  INFO(printf(PREFIX "Setup succesful, entering mainloop.\n"));
+  INFO(fprintf(stderr, PREFIX "Setup succesful, entering mainloop.\n"));
 
   res = test_mainloop(ctx);
 
   cmtspeech_close(ctx->cmtspeech);
   test_dbus_release(ctx);
 
-  INFO(printf(PREFIX "Completed, exiting (%d).\n", res));
+  INFO(fprintf(stderr, PREFIX "Completed, exiting (%d).\n", res));
 
   return res;
 }

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
