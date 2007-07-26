From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: query on nested interrupts on omap2430
Date: Thu, 26 Jul 2007 06:53:53 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290182B185@dlee13.ent.ti.com>
References: <c04186510707252228g29182a52o279c530a1abf0742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c04186510707252228g29182a52o279c530a1abf0742@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: sandeep prabhu <sandeep.mitian@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You should look into the "Understanding the Linux Kernel" book from
O'Reilly it had one of the better descriptions about operation.  The
Love book also gives a little background.  Then look at the code.

Depending on how you attribute your handler on install, interrupts may
or may not be re-enabled at the PIC prior to service dispatch (for all
but the one you are handling).

So yes in general they are.  The NM gave which talked about FIQs is
related but is a separate issue as FIQs are much less flexible by
design.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of sandeep prabhu
> Sent: Thursday, July 26, 2007 12:28 AM
> To: Linux-omap-open-source@linux.omap.com
> Subject: query on nested interrupts on omap2430
>=20
> Hi,
>=20
> I am working on  omap 2430 based custom board, and using 2.6.19 kernel
> downloaded from  linux.omap.com site.
> Please let me know whether nested ( re-entrant ) interrupts are
supported
> in
> 2.6.19 kernel for omap2430 ?
>=20
> --
> Thanks,
> Sandeep
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
