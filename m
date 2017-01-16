From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 16/37] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
Date: Mon, 16 Jan 2017 11:31:23 +0530
Message-ID: <587C61B3.3070107@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-17-git-send-email-kishon@ti.com>
 <20170113180602.GA30346@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170113180602.GA30346@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@infradead.org>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Christoph,

On Friday 13 January 2017 11:36 PM, Christoph Hellwig wrote:
> Hi Kishon,
> 
> a couple comments on the configfs layout based on my experiments with
> your previous drop to implement a NVMe device using it.

Thanks for trying it out!
> 
> I don't think most of these configfs files should be present here, as
> they are properties of the implemented PCIe devices.  E.g. for my
> NVMe device they will be sort of hardcoded most of the time, as they
> would be for other devices that would always have a fixed vendor/device/
> class ID, cacheline size, etc.

Actually not all devices have hardcoded headers. E.g the platform I'm using
doesn't have hardcoded headers and it can be configured based on the function
the user would like to use. If the devices are hardcoded, then using configfs
can be skipped altogether. In such cases, APIs like pci_epf_create() can
directly be used by the drivers instead of going via configfs.

Thanks
Kishon
