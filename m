From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
Date: Wed, 21 Aug 2013 13:31:31 -0700
Message-ID: <20130821203131.GA6692@animalcreek.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com>
 <5214C11F.8090808@baylibre.com> <5214C372.3080402@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5214C372.3080402@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 21, 2013 at 03:41:06PM +0200, Benoit Cousson wrote:
> Hi Mark,

Hi Benoit.

> In fact I cannot even apply these patches since they are referring
> the the edma controller node that does not seem to be there in
> 3.11-rc6.

I just applied them on top of k.o fd3930f (proc: more readdir
conversion bug-fixes) without issue.  I also went through the
resulting code and it looked okay.

Which repo are you applying them to?

If I should put them on top of another repo/branch, just let
me know which one.

Mark
--
