From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: Register the OPP table only for 4430
 device
Date: Thu, 09 Aug 2012 08:01:13 -0700
Message-ID: <878vdogldy.fsf@ti.com>
References: <1344423254-3475-1-git-send-email-rnayak@ti.com>
 <1344423254-3475-3-git-send-email-rnayak@ti.com>
 <87628twbd3.fsf@ti.com> <50236570.6030301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50236570.6030301@ti.com> (Rajendra Nayak's message of "Thu, 09
 Aug 2012 12:53:28 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> Hi Kevin,
>
> On Wednesday 08 August 2012 10:48 PM, Kevin Hilman wrote:
>>> The 4430 OPP table was being registered for all other OMAP4 variants
>>> >  too, like 4460 and 4470 causing issues with cpufreq driver
>>> >  enabled. 4460 and 4470 devices have different OPPs as compared to
>>> >  4430, and they should be populated seperately. As long as that
>>> >  happens, let the OPP table registeration happen only on 4430 device.
>>> >
>>> >  Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Thanks, adding to PM fixes for v3.6-rc (branch: for_3.6/fixes/pm)
>
> I just posted a v2 of this series addressing the issues raised by
> Santosh on Patch 1/2. The problem with taking just $subject fix (or
> taking it before Patch 1/2) is that you would hit the issue fixed
> by the Patch 1/2 and cause a crash on non-4430 based OMAP4 devices with
> cpufreq enabled.

OK, thanks for the warning.  I'll be sure to keep them together.

Kevin
