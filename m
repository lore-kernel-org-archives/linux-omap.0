From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [Patch v1] AM35xx-Craneboard:Update
Date: Thu, 05 May 2011 11:46:34 +0300
Message-ID: <4DC263EA.4080502@compulab.co.il>
References: <1304579708-16018-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304579708-16018-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, jdk@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com
List-Id: linux-omap@vger.kernel.org

Hi Srinath,


On 05/05/11 10:15, srinath@mistralsolutions.com wrote:

> From: Srinath.R <srinath@mistralsolutions.com>
>
> Replaced gpio_request()/gpio_direction_output() with gpio_request_one() in am3517_crane_init.

This has been already done and waits for Tony to apply.
Please, see:
http://www.spinics.net/lists/arm-kernel/msg123823.html


-- 
Regards,
Igor.
