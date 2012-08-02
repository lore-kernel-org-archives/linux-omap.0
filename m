From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: [PATCH 3/3] ARM: OMAP: omap_device: expose hwmod assert/deassert
 to omap devices
Date: Thu, 2 Aug 2012 12:56:37 -0500
Message-ID: <CALLhW=7JL64qaXKSTFsyR8sXPe-PSMZp=d2Rrkno_peSYGyvEg@mail.gmail.com>
References: <1342466485-1050-1-git-send-email-omar.luna@linaro.org>
	<1342466485-1050-4-git-send-email-omar.luna@linaro.org>
	<alpine.DEB.2.00.1208020141140.4177@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1208020141140.4177@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2 August 2012 02:43, Paul Walmsley <paul@pwsan.com> wrote:
>> This APIs are meant to be an interface to hwmod assert/deassert
>> function, omap devices can call them through their platform data
>> to control their reset lines, they are expected to know the name
>> of the reset line they are trying to control.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
>
> This one has been queued for 3.7 with a few changes. Some more detail was
> added to the function documentationrovement.  Also the multiple
> assignments were removed per Documentation/CodingStyle chapter 1:
>
> "Don't put multiple assignments on a single line either."
>
> Please let me know if you have any comments.

Agree.

Thanks,

Omar
