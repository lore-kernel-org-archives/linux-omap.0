From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 0/2] v4l: ti-vpe: Some VPE fixes
Date: Tue, 17 Dec 2013 09:03:47 +0100
Message-ID: <52B00563.7030608@xs4all.nl>
References: <1386071473-10808-1-git-send-email-archit@ti.com> <52B002BD.6000105@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <52B002BD.6000105@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-media@vger.kernel.org, k.debski@samsung.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/17/2013 08:52 AM, Hans Verkuil wrote:
> On 12/03/2013 12:51 PM, Archit Taneja wrote:
>> This series fixes 2 issues in the VPE driver. The first fix allows us to use
>> UYVY color format for source and destination buffers. The second fix makes sure
>> we don't set pixel format widths which the VPDMA HW can't support. None of these
>> fixes are fatal, so they don't necessarily need to go in for the 3.13-rc fixes.
>>
>> Archit Taneja (2):
>>   v4l: ti-vpe: Fix the data_type value for UYVY VPDMA format
>>   v4l: ti-vpe: make sure VPDMA line stride constraints are met
>>
>>  drivers/media/platform/ti-vpe/vpdma.c      |  4 +--
>>  drivers/media/platform/ti-vpe/vpdma.h      |  5 ++-
>>  drivers/media/platform/ti-vpe/vpdma_priv.h |  2 +-
>>  drivers/media/platform/ti-vpe/vpe.c        | 53 ++++++++++++++++++++++--------
>>  4 files changed, 47 insertions(+), 17 deletions(-)
>>
> 
> For this patch series:
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Ah, it's already merged. I missed that :-)

Regards,

	Hans
