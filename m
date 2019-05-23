From: Thomas Huth <thuth@redhat.com>
Subject: Re: [Qemu-devel] Running linux on qemu omap
Date: Thu, 23 May 2019 13:27:34 +0200
Message-ID: <8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
References: <20190520190533.GA28160@Red>
 <20190521232323.GD3621@darkstar.musicnaut.iki.fi>
 <20190522093341.GA32154@Red>
 <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
List-Id: linux-omap@vger.kernel.org

On 22/05/2019 20.19, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, May 22, 2019 at 11:33:41AM +0200, Corentin Labbe wrote:
>> qemu-system-arm -M help |grep OMAP
>> cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
>> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
>> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
>> sx1                  Siemens SX1 (OMAP310) V2
>> sx1-v1               Siemens SX1 (OMAP310) V1
>>
>>>> The maximum I can get with omap1_defconfig is
>>>> qemu-system-arm -kernel zImage -nographic -machine cheetah -append 'root=/dev/ram0 console=ttyO0'
>>>> Uncompressing Linux... done, booting the kernel.
>>>> then nothing more.
> 
> With N800/N810 omap2plus_defconfig should be used instead. However,
> I don't think that works either (but haven't tried recently). Also with
> N800/N810 you need to append the DTB file to the kernel image.

FWIW, Philippe recently posted a mail how to run older kernels on n810:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg610653.html

 HTH,
  Thomas
