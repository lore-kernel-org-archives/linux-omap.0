From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] ARM: OMAP: compile-fixes for PM debug
Date: Tue, 30 Oct 2007 06:18:38 -0700
Message-ID: <47272F2E.2080608@mvista.com>
References: <20071030114040.829831127@mvista.com>
	<31e679430710300514mb809381y72a15edef48da6ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710300514mb809381y72a15edef48da6ad@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Felipe Balbi wrote:
> Hi,
> 
> On 10/30/07, Kevin Hilman <khilman@mvista.com> wrote:
>> Fix compile problems in omap2_pm_debug()
>>
>> Signed-off-by: Kevin Hilman <khilman@mvista.com>
>> ---
>>  arch/arm/mach-omap2/pm.c |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> Index: dev/arch/arm/mach-omap2/pm.c
>> ===================================================================
>> --- dev.orig/arch/arm/mach-omap2/pm.c
>> +++ dev/arch/arm/mach-omap2/pm.c
>> @@ -240,15 +240,15 @@ static void omap2_pm_dump(int mode, int
>>  #endif
>>  #if 0
>>                 DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN1);
>> -               DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN2);
>> +               DUMP_CM_MOD_REG(CORE_MOD, OMAP24XX_CM_FCLKEN2);
> 
> Are you sure this is needed? This code is commented.
> 

It is needed when the code is uncommented, which is used for debugging
suspend/resume and sleep-when-idle.

Kevin
