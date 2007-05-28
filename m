From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Removing Gadget File Storage module
Date: Mon, 28 May 2007 16:13:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705281608560.10323-100000@netrider.rowland.org>
References: <25c21ceb0705280932l32668663y6396faabec70c2ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <25c21ceb0705280932l32668663y6396faabec70c2ab@mail.gmail.com>
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

On Mon, 28 May 2007, Ragner N Magalh=E3es wrote:

> Hi all,
>  I am working with OMAP H2 and when I run "rmmod g_file_storage", it
> stay waiting some thing and not terminate ...
> =

>  Somebody know some thing about this ?

Which version of the Linux kernel are you using?

If you enable debugging in g_file_storage, what shows up in the dmesg =

log?

When the rmmod is waiting, what does a stack trace (Alt-SysRq-T) show?

Really, you shouldn't expect people to be able to help if you don't =

provide any information...

Alan Stern


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
