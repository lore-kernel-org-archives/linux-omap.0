From: Abraham Arce <x0066660@ti.com>
Subject: Re: [PATCH v6 7/8] OMAP4: Keyboard board support
Date: Thu, 30 Sep 2010 02:04:53 -0500
Message-ID: <4CA43695.3030108@ti.com>
References: <1285824973-25550-1-git-send-email-x0066660@ti.com> <20100930064055.GG5260@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100930064055.GG5260@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

Dmitry Torokhov wrote:
> HI Abraham,
> 
> On Thu, Sep 30, 2010 at 12:36:13AM -0500, Abraham Arce wrote:
>> From: Syed Rafiuddin <rafiuddin.syed@ti.com>
>>
>> Keyboard support for SDP OMAP4430
>>
> 
> I think this would benefit from "const" sprinkled on it.

You mean?

-static int sdp4430_keymap[] = {
+static const int sdp4430_keymap[] = {

> 
> BTW, I picked up patches 2, 3, 4, 5, 8 (all touching drivers/input).

Thanks!

Best Regards
Abraham
