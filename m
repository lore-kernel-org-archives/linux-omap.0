From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 1/4] omap: consolidate touch screen initialization among
 different boards
Date: Wed, 04 May 2011 18:10:04 +0300
Message-ID: <4DC16C4C.6030506@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il> <1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il> <4DC15C60.9060401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:52888
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754099Ab1EDPKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 11:10:06 -0400
In-Reply-To: <4DC15C60.9060401@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Weber <thomas.weber.linux@googlemail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Thomas,

On 05/04/11 17:02, Thomas Weber wrote:

> Hello,
>
> because ads7846_get_pendown_state() is not longer set in
> ads7846_platform_data, the ads7846_setup_pendown tries to request the
> pendown gpio and fails because the gpio is already requested.

Thanks, for testing.

I've sent a patch for this a couple of minutes ago.


-- 
Regards,
Igor.

