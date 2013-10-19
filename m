From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] urgent omap related x86 pinctrl build fix for v3.13 merge window
Date: Fri, 18 Oct 2013 17:26:32 -0700
Message-ID: <28107.400381896$1382142409@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17889 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753929Ab3JSA0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 20:26:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit dc7743aa3c49fabbc6dc9edbcf7df74d776ac32e:

  pinctrl: single: Add support for auxdata (2013-10-10 15:30:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/pinctrl-fix

for you to fetch changes up to 1b9c0fb365cbb1154f4e7997061db972cbf58300:

  pinctrl: single: Fix build when not built on ARM (2013-10-18 16:43:06 -0700)

----------------------------------------------------------------
Looks like I managed to break the x86 build for some
configs. Here's a fix for that on top of the pinctrl
changes already merged with the signed tag
omap-for-v3.13/quirk-signed.

----------------------------------------------------------------
Tony Lindgren (1):
      pinctrl: single: Fix build when not built on ARM

 drivers/pinctrl/pinctrl-single.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
