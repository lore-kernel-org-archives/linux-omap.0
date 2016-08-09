From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 1/2] net: davinci_cpdma: reduce time holding ctlr->lock in
 cpdma_control_set
Date: Tue, 9 Aug 2016 13:57:25 +0530
Message-ID: <b8f3672d-7111-a11c-2f5b-69455940b612@ti.com>
References: <1469534545-14478-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1469534545-14478-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1469534545-14478-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On Tuesday 26 July 2016 05:32 PM, Uwe Kleine-König wrote:
> The only user of cpdma_control_set (i.e. cpsw_ndo_open) doesn't check
> the return code, so it doesn't matter, which error triggers. So the
> checks that are independant of the fields protected by ctlr->lock can be
> moved out of the critical section.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
