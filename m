From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Sun, 11 Jun 2006 23:43:09 -0700 (PDT)
Message-ID: <20060612064309.71669.qmail@web37904.mail.mud.yahoo.com>
References: <448C208F.4020102@solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <448C208F.4020102@solidboot.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Juha Yrj=F6l=E4 <juha.yrjola@solidboot.com> wrote:

>=20
> Exactly.  That's why I keep my read_reg/write_reg functions static.=20
> Usually I put even the register definitions to the .c file, since
> other=20
> drivers shouldn't have any business modifying them directly anyway.
>=20

Have them static prcm_read/write_reg means, that clock.c and prcm.c
should be merged, as clock.c is the heaviest user of PRCM/CM_*
registers as of now, and only having static prcm_read/write_reg
functions in prcm.c doesn't solve usage PRCM_* registers from clock.c?

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
