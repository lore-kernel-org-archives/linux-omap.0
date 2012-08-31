From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCHv3 0/4] Add device tree data for omap5
Date: Fri, 31 Aug 2012 11:32:41 +0200
Message-ID: <504084B9.3000701@ti.com>
References: <1344961473-13675-1-git-send-email-sourav.poddar@ti.com> <CAKdam57L8txFtE9ahy3u3vLW0XRP5z4QaNQKVFj9KaEFZE1qvg@mail.gmail.com> <503229F5.4030405@ti.com> <CAKdam543ATO96rbhgCWKtGUGRQ_+=KSyAk-nGBknjC+BvJSmOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdam543ATO96rbhgCWKtGUGRQ_+=KSyAk-nGBknjC+BvJSmOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Poddar, Sourav" <sourav.poddar@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

While rebasing your series on top of Tony's lo/devel-dt, I realized that the keypad nodes are not located at the correct place :-(

At the moment they are just floating at the top level of the dts while they belong to the ocp bus and thus should be put there.

I fixed that since it was trivial and cleaned as well the changelog and the comments to aligned then properly. I added as well the physical address to the node name and a label for easy reference at board level.

I did some basic test on my OMAP4 sdp, but that all I can do so far.

Could you just check if this is still fine for OMAP5 before I ask Tony to pull that.

I based that on top of Tony's DT patches due to conflict with the existing MMC patch in it.



The following changes since commit 85d7ff9b907685b6469058888f1d961b3e8d47ad:
  Olof Johansson (1):
        ARM: omap: add dtb targets

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.7/dts

Sourav Poddar (6):
      arm/dts: omap5-evm: Add I2C support
      arm/dts: omap5-evm: Add tmp102 sensor support
      arm/dts: omap5-evm: Add keypad data
      arm/dts: omap5-evm: Add bmp085 sensor support
      arm/dts: omap4-sdp: Add keypad data
      Documentation: dt: i2c: trivial-devices: Update for tmp102

 .../devicetree/bindings/i2c/trivial-devices.txt    |    1 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   70 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 ++
 arch/arm/boot/dts/omap5-evm.dts                    |   33 +++++++++
 arch/arm/boot/dts/omap5.dtsi                       |   40 +++++++++++
 5 files changed, 149 insertions(+), 0 deletions(-)

Regards,
Benoit
