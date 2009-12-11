From: Juha Leppanen <juha_motorsportcom@luukku.com>
Subject: OMAP: DSS2: DSI Driver: udelays/timeouts
Date: Fri, 11 Dec 2009 14:46:18 +0200 (EET)
Message-ID: <1260535578453.juha_motorsportcom.50821.UM-uY0GfylC9tNgYiVGtKg@luukku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mta-out-0.luukku.com ([193.209.83.52]:53420 "EHLO
	mta-out-0.luukku.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZLKNIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 08:08:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org

Hi,

checking some patches thru www.kernel.org

/drivers/video/omap2/dss/dsi.c

I noticed in many places that if timeout happens,
while "read/status/check" is not done after the last Nth udelay.
Why not "check" after the last udelay?

Lot of different logics for udelays/timeouts:
i=3D0;
while( checking(x) ) {
   udelay(1);
   i++;
   if ( i > N ) {
      /* timeout /*
   }
} /* timeout after N+1 checking(x)'s and N+1 udelay(1)'s,
     no checking(x) done after last udelay */

i=3D0;
while( checking(x) ) {
   udelay(1);
   if ( i++ > N ) {
      /* timeout /*
   }
} /* timeout after N+2 checking(x)'s and N+2 udelay(1)'s,
     no checking(x) done after last udelay */

i=3D0;
while( checking(x) ) {
   if ( i++ > N ) {
      /* timeout /*
   }
   udelay(1);
} /* timeout after N+3 checking(x)'s and N+2 udelay(1)'s,
     checking(x) done!! after last udelay */

/* My version */
i=3D0;
while( checking(x) ) {
   if ( ++i > N ) {
      /* timeout /*
   }
   udelay(1);
} /* timeout after N+1 checking(x)'s and N udelay(1)'s,
     checking(x) done!! after last udelay,
     is this what is intended? This is my understanding. */

Suggested modifications:
=2E.........

static int dsi_pll_power(enum dsi_pll_power_state state)
{
	int t =3D 0;

	REG_FLD_MOD(DSI_CLK_CTRL, state, 31, 30);	/* PLL_PWR_CMD */

	/* PLL_PWR_STATUS */
	while (FLD_GET(dsi_read_reg(DSI_CLK_CTRL), 29, 28) !=3D state) {
-		udelay(1);
-		if (t++ > 1000) {
+		if (++t > 1000) {
			DSSERR("Failed to set DSI PLL power mode to %d\n",
					state);
			return -ENODEV;
		}
+		udelay(1);
	}

	return 0;
}
=2E....
static int dsi_complexio_power(enum dsi_complexio_power_state state)
{
	int t =3D 0;

	/* PWR_CMD */
	REG_FLD_MOD(DSI_COMPLEXIO_CFG1, state, 28, 27);

	/* PWR_STATUS */
	while (FLD_GET(dsi_read_reg(DSI_COMPLEXIO_CFG1), 26, 25) !=3D state) {
-		udelay(1);
-		if (t++ > 1000) {
+		if (++t > 1000) {
			DSSERR("failed to set complexio power state to "
					"%d\n", state);
			return -ENODEV;
		}
+		udelay(1);
	}

	return 0;
}
=2E....
static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
			int x, int y, int w, int h)
{
	/* Note: supports only 24bit colors in 32bit container */
	int first =3D 1;
	int fifo_stalls =3D 0;
<SNIP>
#if 1
		/* using fifo not empty */
		/* TX_FIFO_NOT_EMPTY */
		while (FLD_GET(dsi_read_reg(DSI_VC_CTRL(0)), 5, 5)) {
-			udelay(1);
			fifo_stalls++;
			if (fifo_stalls > 0xfffff) {
				DSSERR("fifo stalls overflow, pixels left %d\n",
						pixels_left);
				dsi_if_enable(0);
				return -EIO;
			}
+			udelay(1);
		}
#elif 1
<SNIP>
=2E....
static int _dsi_wait_reset(void)
{
	int i =3D 0;

	while (REG_GET(DSI_SYSSTATUS, 0, 0) =3D=3D 0) {
-		if (i++ > 5) {
+		if (++i > 5) {
			DSSERR("soft reset failed\n");
			return -ENODEV;
		}
		udelay(1);
	}

	return 0;
}
=2E....

Sorry if this mail is completely pointless,
I just like to see consistent looking code,
that shows you what the intent of the coder is.

Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
Signed-off-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>

No reply needed to me,
my spam filter will probably eat your reply.

Happy hacking,

Mr. Juha Leppanen
Kuopio, Finland

=2E...................................................................
Luukku Plus -paketilla p=E4=E4set eroon tila- ja turvallisuusongelmista=
=2E
Hanki Luukku Plus ja helpotat el=E4m=E4=E4si. http://www.mtv3.fi/luukku
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
