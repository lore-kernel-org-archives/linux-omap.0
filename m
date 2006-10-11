From: Jonathan McDowell <noodles@earth.li>
Subject: Re: Current git and default config
Date: Wed, 11 Oct 2006 08:33:04 +0100
Message-ID: <20061011073304.GQ18091@earth.li>
References: <452AB302.30507@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <452AB302.30507@balister.org>
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

On Mon, Oct 09, 2006 at 04:37:22PM -0400, Philip Balister wrote:
> If you run make omap5917osk_defconfig and build, the build fails because 
> some dsp related symbols are needed. Changing to config to add the dspgw 
> allows the kernel to build and run on the OSK.

Does the patch at

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008064.html

fix the compilation issue for you if you don't change the config?

J.

-- 
Graduate of the Darth Vader School of Personnel Management.
