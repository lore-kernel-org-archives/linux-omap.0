From: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Subject: Re: OMAP 3530 without a PMIC
Date: Wed, 23 Feb 2011 09:14:10 -0500
Message-ID: <0bfe01cbd363$e8ff6a91$cb0a10ac@sypris.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og105.obsmtp.com ([64.18.2.163]:35285 "HELO
	exprod7og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751114Ab1BWON7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 09:13:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org

I will check that out Mark.

I did notice that there was discussion a while back about "dummy regulators". I think that might work -- has anyone tried this approach?



Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

On Tue, Feb 22, 2011 at 03:41:39PM -0500, Boswell, Patrick wrote:

> The twl regulator support must be compiled in to support the MMC reader.
> How do I go about
> creating an "always on" or "not managed" VMMC so that the device
> operates properly?

Use a fixed voltage regulator, or if you don't have any software
controllable regulators in your system at all then just disable the
regulator API and it should stub itself out to look like a fixed voltage
regulator.
