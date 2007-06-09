From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: Re: [PATCH 12/12] Move omap_timer to the initdata section.
Date: Sat, 09 Jun 2007 23:13:38 +0200
Message-ID: <466B1802.1060308@free.fr>
References: <20070609184751.GL1889@varda>
	<fb249edb0706091220n16e50bd4pda35bca25e349adc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0706091220n16e50bd4pda35bca25e349adc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

andrzej zaborowski wrote:
> Hi,
>
> On 09/06/07, Vivien Chappelier <vivien.chappelier@free.fr> wrote:
>> This patch fixes a warning due to omap_timer not belonging to the 
>> __initdata
>> section as it should.
>>
>> Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>
>>
>> ---
>>  arch/arm/mach-omap1/time.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
>> index 3705d20..0ba739c 100644
>> --- a/arch/arm/mach-omap1/time.c
>> +++ b/arch/arm/mach-omap1/time.c
>> @@ -289,6 +289,6 @@ static void __init omap_timer_init(void)
>>         omap_init_clocksource(rate);
>>  }
>>
>> -struct sys_timer omap_timer = {
>> +struct sys_timer omap_timer __initdata = {
>>         .init           = omap_timer_init,
>>  };
>> -- 
>> 1.5.1.3
>
> This was already proposed a couple of times (for example here:
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010075.html) 
>
> but it is wrong because omap_timer is used a lot after initdata is
> discarded. 
This is indeed wrong, seems I got (un)lucky at runtime.. Since there is 
no current way of saying omap_timer.init won't be used after the .init.* 
sections are discared, I agree that we should remove the warning for 
that specific case. But we still lose 4 bytes for a pointer that could 
be discarded :-)
> One possible solution is leaving .init uninitialised, and
> assigning it somewhere during the arch initialisation, with something
> like:
>
>    omap_timer.init = omap_timer_init;
Well, I don't quite like the fact that those warnings are removed based 
on variable names only (as explained here 
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg155753.html), 
so this might be an alternative to consider.

Thanks for pointing out the issue,
Vivien.
