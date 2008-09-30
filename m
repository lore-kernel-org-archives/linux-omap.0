From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH 0/5 v1] ASoC Support for TLVaic23b audio codec
Date: Tue, 30 Sep 2008 15:25:39 +0530
Message-ID: <dfeb90390809300255i74ee5699m4ee2076f816c56f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:33043 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYI3Jzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 05:55:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2785049rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 02:55:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com

Hi all,

I have incorporated the comments from Mark Brown, Jarkko Nikula and
Felipe Balbi.

The following series of patches are against the tree:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

The new series of patches have the following changes from previous patches:

1) The codec is named tlv320aic23 uniformly throughout the code.
2) Removed set_bias_level function from the codec driver and is
switching on/off the
codec at resume/suspend function.
3) Added mic sidetone and line bypass.
4) Renamed the machine driver file as 5912osk.c instead of osk.c

Thanks
Arun
