From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Das u-boot : relocation truncated to fit: R_ARM_PLT32 __div0
Date: Mon, 30 Jul 2007 13:38:45 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429018A889F@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D9130274290182BDD7@dlee13.ent.ti.com>
	<BAY141-F328C5CFCA0C23CF253B114BDEE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <BAY141-F328C5CFCA0C23CF253B114BDEE0@phx.gbl>
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


> Well, I am using omap5912. I changed to the gcc4.1.1 and the warnings =
are
> gone now.

If you go to cpu/arm926ejs/config.mk and switch the type from armv4 to =
armv5 it will likely be fine.

Regards,
Richard W.
