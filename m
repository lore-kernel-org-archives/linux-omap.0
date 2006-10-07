From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Can't Boot - OSK Frame Buffer Support in Kernel 2.6.18-omap1
Date: Sat, 7 Oct 2006 11:52:40 +0100
Message-ID: <20061007105240.GA21713@earth.li>
References: <CC7B089C59ED6841BAE28F1EA69A8543873731@EXCHDB.admin.wpi.edu>
	<CC7B089C59ED6841BAE28F1EA69A8543873732@EXCHDB.admin.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <CC7B089C59ED6841BAE28F1EA69A8543873732@EXCHDB.admin.wpi.edu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 06, 2006 at 04:38:41PM -0400, Sideleau, Scott R wrote:
> Thanks again for working with me, Dirk.  :)
> 
> I wiped everything and started again, using the memory addresses from that
> guide (I had been following a different one)... it still hangs.  Output is as
> follows...
> 
> =====
> ## Booting image at 00040000 ...
>    Image Name:   OE
>    Image Type:   ARM Linux Kernel Image (gzip compressed)
>    Data Size:    1065210 Bytes =  1 MB
>    Load Address: 10c08000
>    Entry Point:  10c08000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> 
> Starting kernel ...
> =====
> 
> The Load Address and Entry Point have remained the same, though.  The rest of
> the flash is empty as I manually erased it all.
> 
> Any ideas?

OOI do you have CONFIG_DEBUG_MUTEXES set? I've found on the E3 having
this set means that the kernel hangs on boot with no output whereas
disabling it results in an ok boot. I've been meaning to go back and try
and work out exactly what's going wrong but haven't got round to it yet.

J.

-- 
/-\                             |    Open mouth, insert foot, echo
|@/  Debian GNU/Linux Developer |          internationally.
\-                              |
