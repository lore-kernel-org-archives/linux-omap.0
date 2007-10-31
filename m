From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
Date: Wed, 31 Oct 2007 08:18:37 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429025C0830@dlee13.ent.ti.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804AF985E@dbde01.ent.ti.com>
	<20071031131059.GG32547@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071031131059.GG32547@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Let's remove the #ifdefs here, we want to be able to compile support
for
> 24xx and 34xx into the same kernel eventually. It's OK to have the
same
> DMA request channel defined in different way for 24xx and 34xx.

One question here is will that happen practically?  Maybe it will, not
sure.  The same sentiments were made about OMAP1 vs. OMAP2.  The
structure which results from the sharing intent perhaps is net positive
but I don't see them converging.

People would likely compiled 3430 for ARMv7 and ARMv6 for 24xx.  Some
new instructions and the like are around.  I don't that its fully
pluggable at the architecture level even.

EABI if really used might allow some fancy solutions in theory but I
wonder if those will develop.  Not to say this the only way.

Regards,
Richard W.
