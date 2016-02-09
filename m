From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
Date: Tue, 9 Feb 2016 16:32:17 +0530
Message-ID: <56B9C739.5050103@ti.com>
References: <1455008743-21660-1-git-send-email-kishon@ti.com>
 <alpine.DEB.2.02.1602090917040.2906@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1602090917040.2906@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 09 February 2016 02:48 PM, Paul Walmsley wrote:
> On Tue, 9 Feb 2016, Kishon Vijay Abraham I wrote:
> 
>> OCP2SCP doesn't support smart idle wakeup according to
>> Table 26-22. OCP2SCP_SYSCONFIG in AM572x TRM [1] and
>> Table 26-22. OCP2SCP_SYSCONFIG in AM571x TRM [2].
>> Remove SIDLE_SMART_WKUP from the list of supported SIDLE modes
>> in hwmod data.
>>
>> [1] -> http://www.ti.com/lit/ug/spruhz6e/spruhz6e.pdf
>> [2] -> http://www.ti.com/lit/ug/spruhz7a/spruhz7a.pdf
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Thanks, queued for v4.6.  If you'd like it queued as a fix, please resend 
> with a description of the regression that it fixes.

Found this during review and as such it didn't cause any regressions. So I
think it's okay to be queued for 4.6

Thanks
Kishon
