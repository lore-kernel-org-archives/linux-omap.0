From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to
 support off-mode
Date: Mon, 29 Jun 2009 14:28:47 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A874D31A30B@dlee01.ent.ti.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-2-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-3-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-4-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-5-git-send-email-khilman@deeprootsystems.com>
	<4A44AD44.4070107@nokia.com> <87bpobjcx6.fsf@deeprootsystems.com>
	<F12CE1A68F023D498A2691C7B5393115035F09BD@ZMY16EXM66.ds.mot.com>,<87y6rb7yz7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60176 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbZF2T24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 15:28:56 -0400
In-Reply-To: <87y6rb7yz7.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, HU TAO-TGHK48 <taohu@motorola.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>


Hi Kevin,

> Shouldn't you do a read-modify-write of I2C_CON_REG here?  Otherwise,
> you're loosing any of the other settings in I2C_CON_REG.
>
> Not being an expert in the I2C hardware, I'm not sure if it matters,
> but this doesn't seem quite right due to possible side effects.

This is a good question and this exact same issue came up on the omapzoom tree. For the omapzoom tree we ended up not implementing a read-modify-write here. The reason being that omap_i2c_unidle is called at the beginning of every transfer and we are re-configuring the I2C_CON register for every transfer. So when consulting with the TI linux team they said that it is ok to simply write 0 and clear the register here so we start over fresh for each transfer.  

I was trying to think if there would be any harm in doing a read-modify-write here. Probably not. You would not want the STT bit (generate a start command) to get set, however, this bit should not be set in the first place when entering this function. 

This change has been implemented in the omapzoom tree and so for you reference please see:
http://git.omapzoom.org/?p=repo/omapkernel.git;a=commit;h=ec70a0af52df54638a4fa33fc0dc3d24b1f893f1

Cheers
Jon
