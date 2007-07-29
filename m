From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Das u-boot : relocation truncated to fit: R_ARM_PLT32 __div0
Date: Sun, 29 Jul 2007 11:04:24 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290182BD1F@dlee13.ent.ti.com>
References: <BAY141-F330A9E03895F40C1C64751BDED0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <BAY141-F330A9E03895F40C1C64751BDED0@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Farhad Rahimi <frk85@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

There are 2 fixes for this.

Early GCC3.4 had a bug which the patch you are looking at is for
(patching and rebuilding your tool chain).  Next you can build u-boot
with out issue.

Later GCC version fixes this so no patch should be necessary.

It seems like the very latest u-boot sources may not have this issue as
someone had went though code and change function usage to try and avoid
functions which result in this.  The ports likely haven't been refreshed
to make use of this.  Using a CodeSourcry tool chain direcly is likely
the easiest thing to do.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Farhad Rahimi
> Sent: Sunday, July 29, 2007 4:01 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Das u-boot : relocation truncated to fit: R_ARM_PLT32 __div0
>=20
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
