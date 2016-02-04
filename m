From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Thu, 4 Feb 2016 23:34:28 +0100
Message-ID: <CAPDyKFrMZYdeun67FBXdWL16DBOuO16qqOxRsks3QBJhNB8SoQ@mail.gmail.com>
References: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
	<Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 4 February 2016 at 23:09, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 4 Feb 2016, Ulf Hansson wrote:
>
>> I am really not questioning the autosuspend feature at all, it's a
>> really great feature!
>>
>> Now, I question the minor benefit we actually gain from having the
>> runtime PM core to update the mark in rpm_resume().
>
> As Tony pointed out, it prevents some devices from going to sleep right
> away.

Because their drivers don't care to update the last busy mark!?

>
>> To me, the best decision when to update the mark is know by the
>> driver/subsystem for the device and not the core.
>>
>> In most cases the mark will be updated after a request has been
>> completed, which leads to one unnecessary update at rpm_resume().
>
> Sure, but that update is a simple assignment statement.  It's about as
> cheap as you can get, short of doing nothing at all.

Valid point. I rest my case. :-)

Thanks for the discussion.

[...]

Kind regards
Uffe
