From: Pavel Machek <pavel@ucw.cz>
Subject: Re: simultaneous voice/data works (was Re: call/normal
 switch was Re: omap4-droid4: voice call support was)
Date: Tue, 10 Apr 2018 12:58:40 +0200
Message-ID: <20180410105840.GA13697@amd>
References: <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
 <20180407081000.GB7818@amd> <20180407122233.GA11302@amd>
 <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
 <20180409140847.GP5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4012066349230085506=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180409140847.GP5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============4012066349230085506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-09 07:08:47, Tony Lindgren wrote:
> * Dan Williams <dcbw@redhat.com> [180408 02:46]:
> > On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
> > > I tried --location-enable-gps-unmanaged , but that did not work for
> > > me.
> >=20
> > That requires a TTY that would spit out the GPS data; in this mode MM
> > only sends the start/stop commands, and what comes out the GPS TTY is
> > undefined (at least by MM).
> >=20
> > So unless you know that one of the 6600's TTYs does GPS and in what
> > format it does GPS, then no.
>=20
> There should be a NMEA port within the unknown port range ttyUSB[123].
>=20
> Is there some easy way to enable --location-enable-gps-unmanaged for
> testing so I can check if GPS gets enabled for one of the ports?

This should be userful for testing:

Just pass --pds-start-gps and you should get NMEA on stdout.

Cleanup does _not_ work properly, so it will fail if you run it too
many times.

								Pavel

diff --git a/src/qmicli/Makefile.am b/src/qmicli/Makefile.am
index eb63fa7..2c5e935 100644
--- a/src/qmicli/Makefile.am
+++ b/src/qmicli/Makefile.am
@@ -42,6 +42,7 @@ qmicli_SOURCES =3D \
 	qmicli-pdc.c \
 	qmicli-uim.c \
 	qmicli-wms.c \
+	qmicli-pds.c \
 	qmicli-wda.c \
 	qmicli-voice.c \
 	qmicli-charsets.c \
diff --git a/src/qmicli/qmicli-loc.c b/src/qmicli/qmicli-loc.c
new file mode 100644
index 0000000..e69de29
diff --git a/src/qmicli/qmicli-pds.c b/src/qmicli/qmicli-pds.c
new file mode 100644
index 0000000..f21ba2e
--- /dev/null
+++ b/src/qmicli/qmicli-pds.c
@@ -0,0 +1,315 @@
+/* -*- Mode: C; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*-=
 */
+/*
+ * qmicli -- Command line interface to control QMI devices
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2015-2017 Aleksander Morgado <aleksander@aleksander.es>
+ */
+
+#include "config.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <locale.h>
+#include <string.h>
+
+#include <glib.h>
+#include <gio/gio.h>
+
+#include <libqmi-glib.h>
+
+#include "qmicli.h"
+#include "qmicli-helpers.h"
+
+/* Context */
+typedef struct {
+    QmiDevice *device;
+    QmiClientPds *client;
+    GCancellable *cancellable;
+} Context;
+static Context *ctx;
+
+/* Options */
+static gboolean get_supported_messages_flag;
+static gboolean reset_flag;
+static gboolean noop_flag;
+static gboolean start_flag;
+
+static GOptionEntry entries[] =3D {
+    { "pds-start-gps", 0, 0, G_OPTION_ARG_NONE, &start_flag,
+      "Start gps",
+      NULL
+    },
+
+    { NULL }
+};
+
+GOptionGroup *
+qmicli_pds_get_option_group (void)
+{
+	GOptionGroup *group;
+
+	group =3D g_option_group_new ("pds",
+	                            "PDS options",
+	                            "Show Wireless Messaging Service options",
+	                            NULL,
+	                            NULL);
+	g_option_group_add_entries (group, entries);
+
+	return group;
+}
+
+gboolean
+qmicli_pds_options_enabled (void)
+{
+    static guint n_actions =3D 0;
+    static gboolean checked =3D FALSE;
+
+    if (checked)
+        return !!n_actions;
+
+    n_actions =3D (get_supported_messages_flag +
+                 reset_flag +
+                 noop_flag +
+                 start_flag);
+
+    if (n_actions > 1) {
+        g_printerr ("error: too many PDS actions requested\n");
+        exit (EXIT_FAILURE);
+    }
+
+    checked =3D TRUE;
+    return !!n_actions;
+}
+
+#if 0
+static void
+context_free (Context *context)
+{
+    if (!context)
+        return;
+
+    if (context->client)
+        g_object_unref (context->client);
+    g_object_unref (context->cancellable);
+    g_object_unref (context->device);
+    g_slice_free (Context, context);
+}
+
+static void
+operation_shutdown (gboolean operation_status)
+{
+    /* Cleanup context and finish async operation */
+    context_free (ctx);
+    qmicli_async_operation_done (operation_status, FALSE);
+}
+#endif
+
+static void
+ser_location_ready (QmiClientPds *client,
+                    GAsyncResult *res,
+                    GTask *task);
+
+static void
+location_event_report_indication_cb (QmiClientPds *client,
+                                     QmiIndicationPdsEventReportOutput *ou=
tput,
+                                     void *self)
+{
+    QmiPdsPositionSessionStatus session_status;
+    const gchar *nmea;
+
+    if (qmi_indication_pds_event_report_output_get_position_session_status=
 (
+                                                                          =
  output,
+                                                                          =
  &session_status,
+                                                                          =
  NULL)) {
+        printf ("[GPS] session status changed: '%s'",
+                qmi_pds_position_session_status_get_string (session_status=
));
+    }
+
+    if (qmi_indication_pds_event_report_output_get_nmea_position (
+                                                                  output,
+                                                                  &nmea,
+                                                                  NULL)) {
+        printf ("%s", nmea);
+    }
+}
+
+static void
+gather_nmea(GTask *task)
+{
+    QmiMessagePdsSetEventReportInput *input;
+   =20
+    /* Only gather standard NMEA traces */
+    input =3D qmi_message_pds_set_event_report_input_new ();
+    qmi_message_pds_set_event_report_input_set_nmea_position_reporting (in=
put, TRUE, NULL);
+    qmi_client_pds_set_event_report (
+                                     ctx->client,
+                                     input,
+                                     5,
+                                     NULL,
+                                     (GAsyncReadyCallback)ser_location_rea=
dy,
+                                     task);
+    qmi_message_pds_set_event_report_input_unref (input);
+
+}
+
+static void
+ser_location_ready (QmiClientPds *client,
+                    GAsyncResult *res,
+                    GTask *task)
+{
+    QmiMessagePdsSetEventReportOutput *output =3D NULL;
+    GError *error =3D NULL;
+
+    output =3D qmi_client_pds_set_event_report_finish (client, res, &error=
);
+    if (!output) {
+        g_prefix_error (&error, "QMI operation failed: ");
+        g_task_return_error (task, error);
+        g_object_unref (task);
+        return;
+    }
+
+    if (!qmi_message_pds_set_event_report_output_get_result (output, &erro=
r)) {
+        g_prefix_error (&error, "Couldn't set event report: ");
+        g_task_return_error (task, error);
+        g_object_unref (task);
+        qmi_message_pds_set_event_report_output_unref (output);
+        return;
+    }
+
+    qmi_message_pds_set_event_report_output_unref (output);
+
+    g_signal_connect (client,
+                      "event-report",
+                      G_CALLBACK (location_event_report_indication_cb),
+                      NULL);
+}
+
+static void
+auto_tracking_state_start_ready (QmiClientPds *client,
+                                 GAsyncResult *res,
+                                 GTask *task)
+{
+    QmiMessagePdsSetAutoTrackingStateOutput *output =3D NULL;
+    GError *error =3D NULL;
+
+    output =3D qmi_client_pds_set_auto_tracking_state_finish (client, res,=
 &error);
+    if (!output) {
+        g_prefix_error (&error, "QMI operation failed: ");
+        g_task_return_error (task, error);
+        g_object_unref (task);
+        return;
+    }
+
+    if (!qmi_message_pds_set_auto_tracking_state_output_get_result (output=
, &error)) {
+        if (!g_error_matches (error,
+                              QMI_PROTOCOL_ERROR,
+                              QMI_PROTOCOL_ERROR_NO_EFFECT)) {
+            g_prefix_error (&error, "Couldn't set auto-tracking state: ");
+            g_task_return_error (task, error);
+            g_object_unref (task);
+            qmi_message_pds_set_auto_tracking_state_output_unref (output);
+            return;
+        }
+        g_error_free (error);
+        printf("no matches: was already enabled?\n");
+    }
+    qmi_message_pds_set_auto_tracking_state_output_unref (output);
+    gather_nmea(task);
+}
+
+
+static void
+gps_service_state_start_ready (QmiClientPds *client,
+                               GAsyncResult *res,
+                               GTask *task)
+{
+    QmiMessagePdsSetAutoTrackingStateInput *input;
+    QmiMessagePdsSetGpsServiceStateOutput *output =3D NULL;
+    GError *error =3D NULL;
+
+    output =3D qmi_client_pds_set_gps_service_state_finish (client, res, &=
error);
+    if (!output) {
+        g_prefix_error (&error, "QMI operation failed: ");
+        g_task_return_error (task, error);
+        g_object_unref (task);
+        return;
+    }
+
+    if (!qmi_message_pds_set_gps_service_state_output_get_result (output, =
&error)) {
+        if (!g_error_matches (error,
+                              QMI_PROTOCOL_ERROR,
+                              QMI_PROTOCOL_ERROR_NO_EFFECT)) {
+            g_prefix_error (&error, "Couldn't set GPS service state: ");
+            g_task_return_error (task, error);
+            g_object_unref (task);
+            qmi_message_pds_set_gps_service_state_output_unref (output);
+            return;
+        }
+        g_error_free (error);
+    }
+    qmi_message_pds_set_gps_service_state_output_unref (output);
+
+    /* Enable auto-tracking for a continuous fix */
+    input =3D qmi_message_pds_set_auto_tracking_state_input_new ();
+    qmi_message_pds_set_auto_tracking_state_input_set_state (input, TRUE, =
NULL);
+    qmi_client_pds_set_auto_tracking_state (
+                                            ctx->client,
+                                            input,
+                                            10,
+                                            NULL, /* cancellable */
+                                            (GAsyncReadyCallback)auto_trac=
king_state_start_ready,
+                                            task);
+    qmi_message_pds_set_auto_tracking_state_input_unref (input);
+}
+
+
+void
+qmicli_pds_run (QmiDevice *device,
+                QmiClientPds *client,
+                GCancellable *cancellable)
+{
+    /* Initialize context */
+    ctx =3D g_slice_new (Context);
+    ctx->device =3D g_object_ref (device);
+    ctx->client =3D g_object_ref (client);
+    ctx->cancellable =3D g_object_ref (cancellable);
+
+    if (start_flag) {
+        QmiMessagePdsSetGpsServiceStateInput *input;
+
+        input =3D qmi_message_pds_set_gps_service_state_input_new ();
+        qmi_message_pds_set_gps_service_state_input_set_state (input, TRUE=
, NULL);
+        qmi_client_pds_set_gps_service_state (
+                                              ctx->client,
+                                              input,
+                                              10,
+                                              NULL, /* cancellable */
+                                              (GAsyncReadyCallback)gps_ser=
vice_state_start_ready,
+                                              ctx);
+        qmi_message_pds_set_gps_service_state_input_unref (input);
+        printf("GPS started?\n");
+        return;
+    }
+
+    if (1) { // run_flag)
+        g_signal_connect (client,
+                          "event-report",
+                          G_CALLBACK (location_event_report_indication_cb),
+                          NULL);
+    }
+
+    g_warn_if_reached ();
+}
diff --git a/src/qmicli/qmicli.c b/src/qmicli/qmicli.c
index fecae8d..32d1052 100644
--- a/src/qmicli/qmicli.c
+++ b/src/qmicli/qmicli.c
@@ -366,6 +366,9 @@ allocate_client_ready (QmiDevice *dev,
     case QMI_SERVICE_WMS:
         qmicli_wms_run (dev, QMI_CLIENT_WMS (client), cancellable);
         return;
+    case QMI_SERVICE_PDS:
+        qmicli_pds_run (dev, QMI_CLIENT_PDS (client), cancellable);
+        return;
     case QMI_SERVICE_WDA:
         qmicli_wda_run (dev, QMI_CLIENT_WDA (client), cancellable);
         return;
@@ -719,6 +722,12 @@ parse_actions (void)
         actions_enabled++;
     }
=20
+    /* PDS options? */
+    if (qmicli_pds_options_enabled ()) {
+        service =3D QMI_SERVICE_PDS;
+        actions_enabled++;
+    }
+
     /* WDA options? */
     if (qmicli_wda_options_enabled ()) {
         service =3D QMI_SERVICE_WDA;
@@ -769,6 +778,8 @@ int main (int argc, char **argv)
     g_option_context_add_group (context,
                                 qmicli_uim_get_option_group ());
     g_option_context_add_group (context,
+                                qmicli_pds_get_option_group ());
+    g_option_context_add_group (context,
                                 qmicli_wms_get_option_group ());
     g_option_context_add_group (context,
                                 qmicli_wda_get_option_group ());
diff --git a/src/qmicli/qmicli.h b/src/qmicli/qmicli.h
index 7db7905..0986b66 100644
--- a/src/qmicli/qmicli.h
+++ b/src/qmicli/qmicli.h
@@ -69,6 +69,14 @@ void          qmicli_uim_run              (QmiDevice *de=
vice,
                                            QmiClientUim *client,
                                            GCancellable *cancellable);
=20
+
+/* PDS group */
+GOptionGroup *qmicli_pds_get_option_group (void);
+gboolean      qmicli_pds_options_enabled  (void);
+void          qmicli_pds_run              (QmiDevice *device,
+                                           QmiClientPds *client,
+                                           GCancellable *cancellable);
+
 /* WMS group */
 GOptionGroup *qmicli_wms_get_option_group (void);
 gboolean      qmicli_wms_options_enabled  (void);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrMmOAACgkQMOfwapXb+vI/LgCcD+5eI9iJN8hYX+MQrUbB5VzR
FxMAoIRf5b93WdcbZbG/h+jLiunX4MMU
=7KEI
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--===============4012066349230085506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4012066349230085506==--
