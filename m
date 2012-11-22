From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER
 to TWL_MODULE_PM_RECEIVER
Date: Thu, 22 Nov 2012 11:26:27 +0100
Message-ID: <50ADFDD3.1080508@ti.com>
References: <1352799152-20980-1-git-send-email-peter.ujfalusi@ti.com>
 <50A4A376.3020703@ti.com> <20121121215234.GB5279@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121121215234.GB5279@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 11/21/2012 10:52 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [121115 00:12]:
>> Hi Tony,
>>
>> On 11/13/2012 10:32 AM, Peter Ujfalusi wrote:
>>> To facilitate upcoming cleanup in twl stack.
>>> No functional change.
>>
>> Would you please consider this patch for 3.8? It would shorten the time =
I'll
>> need to progress on the cleanup regarding to twl-core greatly.
> =

> Please go ahead and merge this with your other patches:
> =

> Acked-by: Tony Lindgren <tony@atomide.com>
> =

> Or let me know if I still need to queue it.

This patch has no dependencies on other patches. It is better to go via
linux-omap.

Thank you,
P=E9ter
