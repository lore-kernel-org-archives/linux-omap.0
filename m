From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Problem with compiling 2.6.10  kernel for OMAP2420 board
Date: Tue, 24 Apr 2007 07:35:49 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429D448F7@dlee13.ent.ti.com>
References: <007b01c7864f$b9ad01d0$5811a80a@cpsingh>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <007b01c7864f$b9ad01d0$5811a80a@cpsingh>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: chandrashekhar singh <cp_singh@faith.co.jp>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Dear All,
> I have downloaded linux kernel 2.6.10 from TI site for OMAP 2420 but
> unable to compile as it gives the error of architecture as follows:
>=20
> Assembler message:
> Error: unknown architecture 'armv6'
>=20
> Though the old version compile well but the latest version does not.
>  Would you please advise me what to do to over come this problem.

It looks like you are using too old of a compiler version.  3.4.0 is
when v6 should first show up.  If you use one before that you need to
switch v6 instructions to dc.l's.

Regards,
Richard W.
