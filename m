From: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Subject: [TLV320AIC23] [AM3517EVM][AUDIO] codec name mis-match in
 soc_bind_dai_link
Date: Tue, 1 Mar 2011 15:22:29 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870370776EC3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42013 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab1CAJwe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 04:52:34 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>

While trying to register the sound card on the AM3517EVM (which uses a tlv320aic23 codec), with the 2.6.37 kernel I get the following error message:
	CODEC tlv320aic23-codec not registered
This is despite having gotten previously:
	Registered codec 'tlv320aic23-codec.2-001a'
I realized that there was a names' mismatch in soc_bind_dai_link():
	In fn soc_bind_dai_link:1249:codec->name is tlv320aic23-codec.2-001a, dai_link->codec_name is tlv320aic23-codec

The 2-001a is the <i2c_bus>-<i2c_address> pair as defined in arch/arm/mach-omap2/board-am3517evm.c:
	static struct i2c_board_info __initdata am3517evm_i2c2_boardinfo[] = {
       {
               I2C_BOARD_INFO("tlv320aic23", 0x1A),
       },
This is the device name of the i2c client set automatically by i2c_new_device() when __process_new_driver() on the device is called, in response to a i2c_register_driver() request.
Now, all devices with names in <i2c_bus>-<i2c_address> are assumed to be i2c clients by snd_soc_register_codec() and so <driver_name>.<dev_name> is the name supplied to the codec.
Now, if I change the dai-link->codec_name to force-match by appending 2-001a to the codec_name in (sound/soc/omap/am3517evm.c):
	static struct snd_soc_dai_link am3517evm_dai = {
			:
      	  .codec_name = "tlv320aic23-codec.2-001a ",
			:
	};

the registration proceeds smoothly and I can see device nodes getting created. 
Since now there is no way to provide a customized i2c device name to a client device (or so I believe), what could be the best solution to this problem ?

-Abhilash
PS: OMAP3 evm does not have this problem as the audio codec twl4030 is on platform bus, I believe.

