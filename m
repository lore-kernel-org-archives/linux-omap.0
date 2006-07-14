From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: OMAP 730: I2S driver
Date: Fri, 14 Jul 2006 20:43:28 +0300
Message-ID: <44B7D7C0.5070902@solidboot.com>
References: <14fc2db60607110701m6a255b77h397295db1297a614@mail.gmail.com>
	<14fc2db60607110704ue119a91j2247bdaecbdf805d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <14fc2db60607110704ue119a91j2247bdaecbdf805d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: chetan.kapoor@flextronicssoftware.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Chetan Kapoor wrote:

> Kindly help if you have come across or know of any open source
> implementation of the I2S driver on OMAP 7xx. I tried searching in the
> .config file which came with the patched kernel for an entry for I2S
> driver, but couldn't find anything.

We're publishing an EAC driver for OMAP2420 in the near future.  It'll 
be merged into the git repository.  I don't know how different the EAC 
blocks on OMAP2420 and OMAP7xx are, but I'm guessing the driver should 
work on OMAP7xx with minimal modifications.

Cheers,
Juha
