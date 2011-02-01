From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 00/13] OMAP: McBSP: hwmod adaptation and
 runtime conversion
Date: Tue, 01 Feb 2011 21:44:03 +0200
Message-ID: <4D486283.6000107@nokia.com>
References: <1296485437-12806-1-git-send-email-kishon@ti.com>
	<20110201195326.b3c9f5f5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110201195326.b3c9f5f5.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, b-cousson@ti.com, khilman@deeprootsystems.com, broonie@opensource.wolfsonmicro.com, paul@pwsan.com, Kishon Vijay Abraham I <kishon@ti.com>, p-basak2@ti.com, charu@ti.com, linux-omap@vger.kernel.org, shubhrajyoti@ti.com, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On 02/01/2011 07:53 PM, ext Jarkko Nikula wrote:
> On Mon, 31 Jan 2011 20:20:24 +0530
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
>> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  APIs.
>>
>> Created on top of linux OMAP master (linux-omap-2.6 :master)
>> Did digital loopback testing on OMAP4430, OMAP3430 and OMAP2430 SDP boards.
>> Verified that this patch series does not break the OMAP1 build.
>>
>> Patch series modifies audio layer and hence would appreciate the help of
>> some audio guy to test this series.
>>
>> Patch series requires the following patch to be present
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
>>
> Generally I don't see any major show stopper here in audio point of
> view after fixing those few minor details. I tested and Beagle plays
> fine and N810 too with some tweaks (not related to this set).

I have not tested the series on HW, but it looks OK for me as well.

All:
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
