From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Mon, 27 May 2019 08:56:53 -0700
Message-ID: <5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
 <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
 <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
 <20190527063250.GI5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527063250.GI5447@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Corentin Labbe <clabbe.montjoie@gmail.com>, linux-omap@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 5/26/19 11:32 PM, Tony Lindgren wrote:
> Hi,
> 
> * Philippe Mathieu-Daudé <philmd@redhat.com> [190523 12:01]:
>> What I use as reference for testing ARM boards [*] is the work of
>> Guenter Roeck:
>> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/run-qemu-arm.sh
> 
> I think Guenter also has v2.3.50-local-linaro branch in his
> github repo that has support for few extra boards like Beagleboard.
> Not sure what's the current branch to use though.
> 
I'd be happy to use a different (supported) branch, but the Linaro branch
was the only one I could find that supports those boards. Unfortunately,
qemu changed so much since 2.3 that it is all but impossible to merge
the code into mainline qemu without spending a lot of effort on it.

Guenter
