From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] ARM: allmodconfig: about cross compiling failure
 under i386 ubuntu.
Date: Thu, 22 Aug 2013 17:19:53 +0800
Message-ID: <5215D7B9.50105@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com>
 <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130822074524.GS7656@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 08/22/2013 03:45 PM, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130821 01:53]:
>> Hello Maintainers:
>>
>> When build arm with allmodconfig under ubuntu i386 with arm-linux-
>> gnueabi-gcc 4.7, as 2.22, it report the errors.
>>
>> Please help check, thanks (the related config file in attachment).
> 
> It seems that some make flags may need to be specified separately
> in some makefiles. See the following for some examples:
> 
> $ find arch/arm -name Makefile | xargs grep -i flags
> 
> I'm getting different errors though, I'm getting:
> 
> arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch
> 
> As probably my compiler does not support the cortex-a9 switch,
> I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.
> 

Thank you for your valuable reply, I followed what you said above, and
now it seems really related the compiler's flags.

I have passed compiling for the VEXPRESS with dcscb, I will compare the
difference between the 2 building flags.

It seems we need add the related dependency for ARCH_VEXPRESS (I am just
analyzing, may get final result today).


Thanks.


> Regards,
> 
> Tony
> 
> 


-- 
Chen Gang
