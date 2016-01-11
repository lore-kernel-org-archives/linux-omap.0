From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: dra7xx pci driver broken on dra7xx-evm
Date: Mon, 11 Jan 2016 14:28:18 +0530
Message-ID: <56936EAA.1040203@ti.com>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com> <568ED7FA.4000508@ti.com>
 <20160107215946.GP12777@atomide.com> <568F520D.9050807@ti.com>
 <20160108092249.GC2344@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160108092249.GC2344@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Cochran <richardcochran@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, "Murphy,
 Dan" <dmurphy@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 08 January 2016 02:52 PM, Richard Cochran wrote:
> On Fri, Jan 08, 2016 at 11:37:09AM +0530, Kishon Vijay Abraham I wrote:
>> All right. I'll post the patch to do reset using platform data.
> 
> Thanks for taking care of this.
> 
> BTW, I am trying to get a new board working.  Are there any *other*
> dra7xx peripherals I should know about, or is the mainline stuff all
> working?

Nothing that I'm aware of. I've tested Ethernet, USB, SATA, MMC and PCIe (with
reset changes) myself. PCI was the only device that needed out of tree patches.

Thanks
Kishon
