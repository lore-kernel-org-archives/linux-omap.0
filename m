From: Ralph Walden <Ralph.Walden@stryker.com>
Subject: Re: 64MB on OMAP1510/5910?
Date: Wed, 12 Dec 2007 13:27:38 -0600
Message-ID: <1197487658.25501.19.camel@amygdala>
References: <20071212180002.ABEF88062A@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071212180002.ABEF88062A@linux.omap.com>
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


> -----Original Message-----
> From: Ladislav Michl [mailto:ladis@linux-mips.org] 
> Sent: Wednesday, December 12, 2007 4:37 AM
> To: Jason Huang
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: 64MB on OMAP1510/5910?
> 
> On Wed, Dec 12, 2007 at 01:21:56AM -0800, Jason Huang wrote:
> > Hello All,
> > 
> > I searched over the mailing list and did not find a solution for
> > OMAP1510/5910 to use more than 32 MB.
> > 
> > Has anyone made 64MB work on 1510/5910?
> 
> Voiceblue board comes with 64MB RAM, however USB host doesn't work,
> because its driver code maps only 32MB staticaly.
> 
> Best regards,
> 	ladis
> 


As I recall, this is possible, but undocumented.  It will work,
depending on the particular SDRAM you have.  

Set the SDRAM_TYPE field of the EMIFF_SDRAM_CONFIG register to 1101.
Even though the TRM (or SPRU673) says this setting is for 8-bit data bus
width, it works for our 16-bit bus configuration, and I can access 64MB.

Perhaps any listening TI folks could elaborate...


Ralph Walden

This email, including attachments, may include confidential and/or proprietary information, and may be used only by the person or entity to which it is addressed. If the reader of this email is not the intended recipient or their authorized agent, the reader is hereby notified that any dissemination, distribution or copying of this e-mail is prohibited. If you have received this email in error, please notify the sender by replying to this message and deleting the email immediately.
