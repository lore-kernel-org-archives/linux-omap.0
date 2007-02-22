From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Kernel compilation problem
Date: Thu, 22 Feb 2007 07:10:27 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429682D08@dlee13.ent.ti.com>
References: <63576.32055.qm@web30611.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <63576.32055.qm@web30611.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Zgembo Adislic <adislic_zgembo@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>  "stdio.h: No such file or directory"
> And all functions that I used form that library are not recognized.

They don't exist in that form in the kernel context.  Only
user/application context is this available.

>  I really see no reason why this should not work?! All suggestions are
> welcome.

Your expectation is not correct.  Things in the kernel are built and
have different attributes as compared for things meant for user space.

Subsets of the common C Library functions are available in the kernel.
They do not always carry all the features of the
glibc/uclibc/newlibc/... counterparts.  The kernel environment is much
more restrictive.

Regards,
Richard W.
