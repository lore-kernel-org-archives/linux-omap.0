From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Waiting while MMC busy
Date: Thu, 08 Jan 2009 16:11:43 +0200
Message-ID: <4966099F.2040203@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34215 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbZAHOAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 09:00:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Mohit Jalori <mjalori@ti.com>
Cc: "Lavinen Jarkko (Nokia-M/Helsinki)" <jarkko.lavinen@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi

At present, the omap_hsmmc driver completes a write request while
the card is still busy.  The mmc_block driver caters for this by
waiting while the card is busy, but it does so by repeated requesting
the card status until the state is not "programming" and the
READ_FOR_DATA bit is set. e.g. the code from the block driver
driver/mmc/card/block.c:

static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
{
...
		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
			do {
				int err;

				cmd.opcode = MMC_SEND_STATUS;
				cmd.arg = card->rca << 16;
				cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
				err = mmc_wait_for_cmd(card->host, &cmd, 5);
				if (err) {
					printk(KERN_ERR "%s: error %d requesting status\n",
					       req->rq_disk->disk_name, err);
					goto cmd_err;
				}
				/*
				 * Some cards mishandle the status bits,
				 * so make sure to check both the busy
				 * indication and the card state.
				 */
			} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
				(R1_CURRENT_STATE(cmd.resp[0]) == 7));

We would much prefer to use an interrupt but we cannot see any suitable
interrupt bit in the OMAP HSMMC.  When we look at MMCHS_PSTATE we see
that DLA, DATI and CMDI are zero even while dat0 is low (as seen from
DLEV bit 20).

We are considering using pad configuration to switch dat0 to gpio while
waiting because dat0 is held low when the card is busy and returns high
when it is ready.  Then we can use a gpio interrupt.

Does anyone have any other ideas?

Regards
Adrian Hunter
