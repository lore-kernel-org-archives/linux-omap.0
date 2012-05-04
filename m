From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: Add platform devices for
	ASoC HDMI drivers
Date: Thu, 3 May 2012 20:51:15 -0500
Message-ID: <4FA33613.6050907@ti.com>
References: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
	<4F9888D4.5090207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4F9888D4.5090207@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com
Cc: alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This is me again; asking if you had any chance to look at these patches.

Thanks!

Ricardo
On 04/25/2012 06:29 PM, Ricardo Neri wrote:
> Hi Tony,
>
> I was wondering if you've had the time to take a look at these patches.
>
> Thanks!
>
> Ricardo
> On 04/17/2012 07:40 PM, Ricardo Neri wrote:
>> This set of patches is intended to add the platform devices for the ASoC
>> HDMI drivers when not using device tree. For this, I took an approach
>> similar
>> to DMIC and McPDM by creating a dedicated functions to create the
>> devices.
>>
>> I included the device for the CPU DAI driver, omap-hdmi-audio-dai, and
>> the
>> device for the machine driver, omap-hdmi-audio, in devices.c to
>> reflect the
>> fact that any OMAP4 (and OMAP5 in the future) has HDMI IP. I put the
>> device
>> for the codec in the board file to reflect the fact that not
>> necessarily all
>> the boards with OMAP4/5 have the HDMI output wired.
>>
>> Best regards
>>
>> Ricardo
>>
>> Ricardo Neri (3):
>> ARM: OMAP: devices: Register platform devices for HDMI audio
>> ARM: OMAP4: board-4430sdp: Register platform device for HDMI audio
>> codec
>> ARM: OMAP4: board-omap4panda: Register platform device for HDMI audio
>> codec
>>
>> arch/arm/mach-omap2/board-4430sdp.c | 6 ++++++
>> arch/arm/mach-omap2/board-omap4panda.c | 6 ++++++
>> arch/arm/mach-omap2/devices.c | 31 +++++++++++++++++++++++++++++++
>> 3 files changed, 43 insertions(+), 0 deletions(-)
>>
>
