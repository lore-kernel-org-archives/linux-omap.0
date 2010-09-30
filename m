From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 7/8] OMAP4: Keyboard board support
Date: Thu, 30 Sep 2010 00:36:40 -0700
Message-ID: <393CAC30-2B6A-4473-9C43-15C0C1464169@gmail.com>
References: <1285824973-25550-1-git-send-email-x0066660@ti.com> <20100930064055.GG5260@core.coreip.homeip.net> <4CA43695.3030108@ti.com>
Mime-Version: 1.0 (iPhone Mail 8B117)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <4CA43695.3030108@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Abraham Arce <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sep 30, 2010, at 12:04 AM, Abraham Arce <x0066660@ti.com> wrote:

> Hi Dmitry,
> 
> Dmitry Torokhov wrote:
>> HI Abraham,
>> On Thu, Sep 30, 2010 at 12:36:13AM -0500, Abraham Arce wrote:
>>> From: Syed Rafiuddin <rafiuddin.syed@ti.com>
>>> 
>>> Keyboard support for SDP OMAP4430
>>> 
>> I think this would benefit from "const" sprinkled on it.
> 
> You mean?
> 
> -static int sdp4430_keymap[] = {
> +static const int sdp4430_keymap[] = {

Yep. 

-- 
Dmitry

> 
