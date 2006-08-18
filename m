From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [Dspgateway-devel] OMAP2420 DSPGW status?
Date: Thu, 17 Aug 2006 22:34:27 -0700 (PDT)
Message-ID: <20060818053427.74135.qmail@web37905.mail.mud.yahoo.com>
References: <1155807521.15232.268585018@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1155807521.15232.268585018@webmail.messagingengine.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: dspgateway-devel@lists.sourceforge.net, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Komal Shah <komal_shah802003@yahoo.com> wrote:

> Toshiharo-San/Paul,
> 
> Could you please provide us the status of OMAP2420-DSPGW porting now?
> Are you able to execute some test application with that? 
> 
> See that TI uses now their simplified COFF format, they call it DOFF
> (Dynamic
> Object File Format), and it seems to be properietary. I believe that
> it is
> nothing but just re-organization of the COFF file, so that it
> compresses well,
> and then able to reduce the loading time ultimately along with size.
> 
> So, are you still using the same COFF loader as in case with 1710-GW
> or do you have
> the DOFF-TO-COFF converter and then loading on OMAP2420-DSP? As say,
> if you are
> using the external third-party codecs, they usually now distribute in
> form of
> .doff files ;)
> 
> Are you also considering writing some generic code-apis/framework for
> OMAP2
> MMU and IPC-MBox as it remains same for IVA1.0 too.?

Apart from that, we have lots of IOCTLs for the existing dspgw.
Ofcourse as per driver model we are using the sysfs as necessary, but I
would also suggest for coming up with some kind of virtual filesystem
to handle all those tasks to truely make it scalable for multiple async
processors. e.g OMAP2 with adding support for IVA, where we have
multple co-processors inside (vlcd, seq, imx buffers) each having their
SRAM, where code needs to be loaded as generated in DOFF file, for
which you can also export those memories to userspace to have dump of
those SRAMs for easy debugging ;). How about naming it iva/dsp-fs?

PS:
Are you able to access dspgw-devel archives? I am also CCing to
linux-omap-open-source for archive purpose.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
