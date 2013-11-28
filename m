From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory
 mapped.
Date: Thu, 28 Nov 2013 10:54:12 +0530
Message-ID: <5296D37C.2020003@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-13-git-send-email-sourav.poddar@ti.com>
 <20131126131138.GJ14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131126131138.GJ14725@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, computersforpeace@gmail.com, balbi@ti.com, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Mark,
On Tuesday 26 November 2013 06:41 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 01:05:08PM +0530, Sourav Poddar wrote:
>> Idea is to enable memory mapped by default at the end of the probe,
>> if the control reaches the "transfer" api, then the operation is
>> not a memory mapped one. Hence, we switch to Normal mode and at the
>> end of the "transfer" function. switch back to memory mapped mode.
> This doesn't see safe, what happens if something tries to use the map
> while a transfer is in progress?
Transfer gets initiated with the following api "ti_qspi_start_transfer_one".

At the beginning of this api, I am doing a "disable memory mapped", as 
becuase of
the code implemntation, if the control has reaches this api, memory 
mapped is not
the desired operation. Then, at the end of this api after
"spi_finalize_current_message(master)", which indicated the current 
transfer complete, I
issue a end of transfer command. Only after which, I enable memory 
mapped mode again.

So, will the condition you mention above will hit.? Please help me 
understand if i am
missing something?


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
