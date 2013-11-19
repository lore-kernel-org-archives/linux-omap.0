From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC] ARM/dts: am335x-boneblack: Add HDMI
	audio support
Date: Tue, 19 Nov 2013 15:29:26 +0200
Message-ID: <528B67B6.6040706@ti.com>
References: <cover.1384863282.git.jsarha@ti.com>
 <18d71a32fb46d34197fd2e0ec5dc8ebc36371704.1384863282.git.jsarha@ti.com>
 <528B617A.4080102@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <528B617A.4080102@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/19/2013 03:02 PM, Benoit Cousson wrote:
> A side question related to audio cape support on BBB. In the "official"
> 3.8.13 CircuitCo version the HDMI audio support was breaking the
> audio-cape support due to some bad hacks in the mcasp driver.
>
> Is this still the case with you series?

My patches do not touch davinci-mcasp at all and the davinci-evm changes 
should be backwards compatible. So if the audio-cape was working before 
my patches should not break it.

Best regards,
Jyri
