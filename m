From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Removing Gadget File Storage module
Date: Wed, 30 May 2007 11:01:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705301059230.2564-100000@iolanthe.rowland.org>
References: <25c21ceb0705290822l69271364pcdc6ded14dcde9e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <25c21ceb0705290822l69271364pcdc6ded14dcde9e3@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Ragner_N_Magalh=E3es?= <ragner@users.sourceforge.net>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

On Tue, 29 May 2007, Ragner N Magalh=E3es wrote:

> On 5/28/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Mon, 28 May 2007, Ragner N Magalh=E3es wrote:
> >
> > > Hi all,
> > >  I am working with OMAP H2 and when I run "rmmod g_file_storage", it
> > > stay waiting some thing and not terminate ...
> > >
> > >  Somebody know some thing about this ?
> >
> > Which version of the Linux kernel are you using?
> =

> I am using the last omap git tree from
> http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

The same thing happened to me when I tried using g_file_storage on a
recent kernel.  The answer turns out to be that signal handling for
kernel threads was changed in 2.6.22.  The patch below fixed the driver
on my system.

Alan Stern


Index: usb-2.6/drivers/usb/gadget/file_storage.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- usb-2.6.orig/drivers/usb/gadget/file_storage.c
+++ usb-2.6/drivers/usb/gadget/file_storage.c
@@ -686,7 +686,6 @@ struct fsg_dev {
 	int			thread_wakeup_needed;
 	struct completion	thread_notifier;
 	struct task_struct	*thread_task;
-	sigset_t		thread_signal_mask;
 =

 	int			cmnd_size;
 	u8			cmnd[MAX_COMMAND_SIZE];
@@ -3277,8 +3276,7 @@ static void handle_exception(struct fsg_
 	/* Clear the existing signals.  Anything but SIGUSR1 is converted
 	 * into a high-priority EXIT exception. */
 	for (;;) {
-		sig =3D dequeue_signal_lock(current, &fsg->thread_signal_mask,
-				&info);
+		sig =3D dequeue_signal_lock(current, &current->blocked, &info);
 		if (!sig)
 			break;
 		if (sig !=3D SIGUSR1) {
@@ -3431,10 +3429,10 @@ static int fsg_main_thread(void *fsg_)
 =

 	/* Allow the thread to be killed by a signal, but set the signal mask
 	 * to block everything but INT, TERM, KILL, and USR1. */
-	siginitsetinv(&fsg->thread_signal_mask, sigmask(SIGINT) |
-			sigmask(SIGTERM) | sigmask(SIGKILL) |
-			sigmask(SIGUSR1));
-	sigprocmask(SIG_SETMASK, &fsg->thread_signal_mask, NULL);
+	allow_signal(SIGINT);
+	allow_signal(SIGTERM);
+	allow_signal(SIGKILL);
+	allow_signal(SIGUSR1);
 =

 	/* Arrange for userspace references to be interpreted as kernel
 	 * pointers.  That way we can pass a kernel pointer to a routine


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
