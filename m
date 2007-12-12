From: "Meng Hu" <meng.hu@gmail.com>
Subject: Re: McSPI interfaces in newer kernel
Date: Wed, 12 Dec 2007 17:34:35 -0600
Message-ID: <94d6903b0712121534yca6ea28sfa722f9299c4562f@mail.gmail.com>
References: <94d6903b0712111115h297769e2q1709777dd0e65bb7@mail.gmail.com>
	<87y7c13suo.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <87y7c13suo.fsf@vence.hilman.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thank you, Kevin.
With the MontaVista Mobilinux 5.0 release, should I expect specific
patches for Omap2430 like those for Mobilinux 4.1?
I had to port a few things from the old kernel patches to make the new
kernel work(Mostly OMAP2430-specific stuff)

For the new McSPI interface, I am not sure if they are missing any
functionality for now.
I actually ported the old TI McSPI interfaces to the new kernel and
they seem to work fine.
I may post an update if we get a chance to implement the touchscreen
drivers using the new McSPI interfaces.

-Meng

On Dec 11, 2007 1:59 PM, Kevin Hilman <khilman@mvista.com> wrote:
> "Meng Hu" <meng.hu@gmail.com> writes:
>
> > I am trying to jump from a 2.6.10 montavista kernel to a 2.6.21 one
> > for OMAP2430.
> > There are some patches from MonvaVista(originally provided by TI) for
> > the 2.6.10 kernel which provides some McSPI  implementations, e.g.
> > drivers/ssi/omap-mcspi.c
> >
> > I found that these files are not in my 2.6.21 kernel and neither in
> > the upstream omap linux tree.
>
> For the MV 2.6.21-based kernel, we moved from using the TI SPI driver
> to the upstream driver (drivers/spi/omap2_mcspi.c)
>
> > Is this because the upstream kernel only contains a small set of omap
> > drivers OR these old mscpi drivers are replaced by sth. else?
>
> The "old" driver you're referring to was never upstream, it's only in
> the TI kernel (and re-used in the MV kernel.)  For the MV 2.6.21-based
> kernel, since there was an upstream driver, we moved to the upstream
> driver.
>
> There are many drivers/features which are in the TI kernels which are
> not in the upstream kernels.  Feel free to help us all remedy that.
> Patches are welcome.  :)
>
> > Should I port these files by myself? or change my other drivers to use
> > the new interfaces. (I am porting a touchscreen driver which heavily
> > relies on the old mscpi drivers)
>
> I would recommend you use the new driver.  If there is any
> functionality in the older driver that is not in the newer one, I
> recommend you report it here, preferably with a patch that adds it to
> the new driver.  :)
>
> Kevin
>
