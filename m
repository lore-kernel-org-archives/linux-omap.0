From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: PROBLEMS WITH DNS
Date: Fri, 8 Jun 2007 20:38:41 +0100
Message-ID: <20070608193840.GA12975@flint.arm.linux.org.uk>
References: <c7af2a170706081023w25076e1eq4a791b02a977f9f@mail.gmail.com>
	<4669945F.5070708@mbdsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4669945F.5070708@mbdsys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vadim Lebedev <vadim@mbdsys.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, Eduardo Franceschini <edumontenegro@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 08, 2007 at 07:39:43PM +0200, Vadim Lebedev wrote:
> this DHCP request are sent by kernel mode dhcp client,  which has no access
> to resolv.conf to store retrived information

The kernel mode dhcp client is for supporting root-NFS, where you
need to bring up a network interface in order to access your root
filesystem.

It's not supposed to be a subsitute for having a dhcp client in your
local rootfs if you have a local rootfs.

> I'dont now if somebody have developped a possibility to retriev this 
> info using user-mode app and store it into resolv.conf...

The kernel doesn't even ask for DNS information when querying the DHCP
server, so the DHCP server doesn't supply that information.
