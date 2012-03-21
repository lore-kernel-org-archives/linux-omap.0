From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v8 4/8] ARM: davinci: Consolidate time keeping and irq
 enable
Date: Wed, 21 Mar 2012 15:37:57 +0000
Message-ID: <DF0F476B391FA8409C78302C7BA518B631800A29@DBDE01.ent.ti.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <1332274969-15782-5-git-send-email-rob.lee@linaro.org>
 <CAMXH7KH5kS=wPFdC8QrtnhE6_sZqmsJ8h=6Gs3kfHOTbeHjacA@mail.gmail.com>
 <CAP245DW9SdTYNc8XXwiuHzo5Y-aZrLc2qP0MekKkyAT2TosjbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAP245DW9SdTYNc8XXwiuHzo5Y-aZrLc2qP0MekKkyAT2TosjbQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Amit Kucheria <amit.kucheria@linaro.org>, Rob Lee <rob.lee@linaro.org>
Cc: "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "venki@google.com" <venki@google.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kernel@wantstofly.org" <kernel@wantstofly.org>, "Hilman,
 Kevin" <khilman@ti.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "arnd.bergmann@linaro.org" <arnd.bergmann@linaro.org>, "Hunter,
 Jon" <jon-hunter@ti.com>, "len.brown@intel.com" <len.brown@intel.com>, "patches@linaro.org" <patches@linaro.org>, "jean.pihet@newoldbits.com" <jean.pihet@newoldbits.com>, rjw@
List-Id: linux-omap@vger.kernel.org

Hi Amit,

On Wed, Mar 21, 2012 at 20:06:29, Amit Kucheria wrote:
> Rob, you should start a new '3.4-fixes' branch containing such
> bugfixes that can be pushed to Len after -rc1.

I think it is OK to send the fixes to Len right away so
he can queue the fixes during merge window if he gets the
chance. That way we may get a non-broken -rc1.

Thanks,
Sekhar
