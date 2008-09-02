From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [alsa-devel] [PATCH 2/4] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Tue, 2 Sep 2008 15:27:18 +0300
Message-ID: <20080902122718.GB7089@gandalf.research.nokia.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com> <1220306279-27977-2-git-send-email-sakoman@gmail.com> <1220306279-27977-3-git-send-email-sakoman@gmail.com> <20080902112633.GB25176@sirena.org.uk>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46066 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbYIBM1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 08:27:45 -0400
Content-Disposition: inline
In-Reply-To: <20080902112633.GB25176@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Tue, Sep 02, 2008 at 12:26:33PM +0100, ext Mark Brown wrote:
> Perhaps I'm missing something but I can't seem to see where
> twl4030_i2c_read_u8() is defined or any of the I2C device hookup for the
> codec is done?

The driver still sitting on linux-omap only, it's under
drivers/i2c/chips/twl4030-core.c

-- 
balbi
