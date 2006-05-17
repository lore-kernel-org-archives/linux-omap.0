From: "Marco Candiago" <Marco.Candiago@nicta.com.au>
Subject: RE: Userspace GPIO
Date: Wed, 17 May 2006 14:09:00 +1000
Message-ID: <09D3F703EF3B0A4CBE28449EA9F3D320477ADA@nicta-atp-mail.in.nicta.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Matt Callow <mc-lists@tesco.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Matt, Richard,

Thanks for your replies.

Matt,=0D
=0D
	devmem2 does do the job and is ridiculously easy to use.

Richard,=0D

 I understand what you are saying, but I simply do not know how to
create a proxy of this nature.  Do you have any recommended
documentation that would=0D
Enlighten me.

Marco


-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Woodruff, Richard
Sent: Tuesday, May 16, 2006 10:10 PM
To: Matt Callow
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: Userspace GPIO

> Since the GPIO lines are mapped into the ARM memory space, you can use
a
> program like devmem2 to access the memory locations directly. Maybe
not
> the most elegant solution but I've used the program successfully on an
> OMAP board. Try searching for devmem2.c in google.

I wouldn't recommend that.  32 GPIOs are controlled per register.  A
direct user space write with out any locking could destroy the state of
a gpio owned by someone else.  If someone really wanted to use it, then
some proxy between (/proc/sys/syscall) to the real kernel API should be
created.  It might be fun to have some notification method if the GPIO
were configured as an interrupt source.

Regards,
Richard W.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source

--------------------------------------------------------------------------
This email and any attachments may be confidential. They may contain=
 legally
privileged information or copyright material. You should not read, copy,
use or disclose them without authorisation. If you are not an intended
recipient, please contact us at once by return email and then delete both
messages. We do not accept liability in connection with computer virus,
data corruption, delay, interruption, unauthorised access or unauthorised
amendment. This notice should not be removed.
