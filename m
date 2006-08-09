From: Mark Howell <mhowell@northlink.com>
Subject: Re: ARM: OMAP: Fix OMAP1 compilation after MPUIO check change.
Date: Wed, 09 Aug 2006 16:46:39 -0700
Message-ID: <44DA73DF.7080308@northlink.com>
References: <20060809092544.GK27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060809092544.GK27094@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, Imre Deak <imre.deak@solidboot.com>
List-Id: linux-omap@vger.kernel.org

Jonathan McDowell wrote:
> The recent MPUIO range change fix breaks compilation if
> CONFIG_ARCH_OMAP24XX isn't defined; it should be OMAP_MAX_GPIO_LINES not
> MAX_GPIO_LINES I believe. This one liner fixes it.
> 

Thanks, this works for me on my 1611 H2 with today's 2.6.18-rc4 from
git. Mark.
