From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
Date: Fri, 7 Feb 2014 12:44:13 +0200
Message-ID: <52F4B8FD.1030106@ti.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <5240492D.6060204@ti.com> <52F4B682.2000201@ti.com>
 <463926864.ALblgUKdgH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <463926864.ALblgUKdgH@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, balajitk@ti.com, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Hans de Goede <hdegoede@redhat.com>, tony@atomide.com, linux-kernel@vger.kernel.org, balbi@ti.com, kishon@ti.com, linux-ide@vger.kernel.org, bcousson@baylibre.com, Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/07/2014 12:39 PM, Arnd Bergmann wrote:
> On Friday 07 February 2014 12:33:38 Roger Quadros wrote:
>>
>> This means we need to make CONFIG_SATA_AHCI_PLATFORM depend on CONFIG_GENERIC_PHY or
>> select it.
>>
>> OR
>>
>> Generic PHY layer must be fixed so that the API's are always built in.
>>
>> What is the better option? I believe making the PHY API's always built in is the better option.
>>
> 
> CONFIG_SATA_AHCI_PLATFORM should do
> 
> 	"depends on CONFIG_GENERIC_PHY || !CONFIG_GENERIC_PHY"
> 
> which is the Kconfig way of saying that if CONFIG_GENERIC_PHY is a module,
> CONFIG_SATA_AHCI_PLATFORM needs to be a module as well.
> 

Ah, that's neat. Thanks :).

cheers,
-roger
