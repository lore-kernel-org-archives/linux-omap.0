From: Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH 04/17] spi/qspi: parse control module register.
Date: Tue, 26 Nov 2013 18:30:15 +0530
Message-ID: <52949B5F.7010304@ti.com>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-5-git-send-email-sourav.poddar@ti.com>
 <20131126103104.GZ14725@sirena.org.uk> <529483A2.3080000@ti.com>
 <20131126122512.GD14725@sirena.org.uk> <5294964A.8020507@ti.com>
 <20131126125535.GF14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131126125535.GF14725@sirena.org.uk>
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

On Tuesday 26 November 2013 06:25 PM, Mark Brown wrote:
> On Tue, Nov 26, 2013 at 06:08:34PM +0530, Sourav Poddar wrote:
>> On Tuesday 26 November 2013 05:55 PM, Mark Brown wrote:
>>> On Tue, Nov 26, 2013 at 04:48:58PM +0530, Sourav Poddar wrote:
>>>> I have added a "reg-name" property. Does we need to add individual
>>>> reg-names also?
>>> I don't understand what you mean by "individual reg-names"?
>> I have added a binding named "reg-names" in my documentation
>> patch.
> OK, but I stil don't understand the above?
I mean to say, do I need to document "qspi_base", "qspi_ctrlmod" 
register names
also which I have used in omy dts files.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
