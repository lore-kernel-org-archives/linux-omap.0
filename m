From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 00/10] crypto: omap fixes towards 5.5
Date: Thu, 17 Oct 2019 15:25:39 +0300
Message-ID: <20191017122549.4634-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: herbert@gondor.apana.org.au, davem@davemloft.net, linux-crypto@vger.kernel.org, ard.biesheuvel@linaro.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series fixes a number of bugs with omap crypto implementation.
These have become evident with the changes to the cryptomanager, where
it adds some new test cases and modifies some existing, namely the split
update tests. Also, while fixing the cryptomanager induced bugs, some
other surfaced with tcrypt/IPSec tests, so fixed them aswell.

Patch #9 is against crypto core modifying the crypto_wait_req
common API to have a timeout for it also, currently it waits forever
and it is kind of difficult to see what test fails with crypto manager.
This is not really needed for anything, but it is kind of nice to have
(makes debugging easier.)

This series has been tested on top of 5.4-rc2, with following setups,
on AM57xx-beagle-x15 board:

- crypto manager self tests
- tcrypt performance test
- ipsec test with strongswan

This series depends on the skcipher API switch patch from Ard Biesheuvel
[1].

-Tero

[1] https://patchwork.kernel.org/patch/11188595/


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
