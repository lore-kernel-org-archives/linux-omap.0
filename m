From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 10:05:44 -0500
Message-ID: <4C9383C8.4020608@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Granados
	Dorado, Rober
List-Id: linux-omap@vger.kernel.org

Linus Walleij had written, on 09/17/2010 08:41 AM, the following:
> 2010/9/17 Nishanth Menon <nm@ti.com>:
> 
>> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
>> index fb742c2..45e9d4a 100644
>> --- a/Documentation/power/00-INDEX
>> +++ b/Documentation/power/00-INDEX
>> @@ -14,6 +14,8 @@ interface.txt
>>        - Power management user interface in /sys/power
>>  notifiers.txt
>>        - Registering suspend notifiers in device drivers
>> +opp.txt
>> +       - Operating Performance Point library
>>  pci.txt
>>        - How the PCI Subsystem Does Power Management
> 
> Hm you add the documentation to the index but not the documentation
> itself (easy slip) would you mind posting it?
ouch.. Sorry.. I realized that I missed adding MAINTAINER entry as 
well.. v2 coming up..

-- 
Regards,
Nishanth Menon
