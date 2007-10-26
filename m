From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/2] CPU id and silicon rev check support
Date: Fri, 26 Oct 2007 12:20:05 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290253097A@dlee13.ent.ti.com>
References: <000101c817e6$59bb6770$6a8918ac@ent.ti.com>
	<1193414583.23273.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <1193414583.23273.6.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Igor Stoppa <igor.stoppa@nokia.com>, "Ghongadematt, Girish" <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Is there any way to identify at runtime a speed sorted omap vs a
> standard one?
> Then some of the code we have for N800/N810 could be moved from board =
to
> arch.

I don't believe that information is encoded anywhere today for 2420 =
which is sufficient for your needs.  The 1.4v DM addendum does show an =
external marking difference.=20

You probably could pass this information up from your boot loader as an =
ATAG.  Or rely on say the Menelaus root voltage level to let the system =
know.  You also surly tie it to some N8xx board attribute.  All N810's =
have it and all rev2 N800's have it or something.

The only OMAP chip way today would probably rely on maintenance of large =
tables leveraging production specific information scattered here and =
there.  Of which is mostly not documented today.  And these tables would =
be ever growing.

Regards,
Richard W.
