From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Audio capture not working with AIC23/McBSP1 on OMAP3517
Date: Wed, 26 Aug 2009 18:30:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I am trying to capture audio through LineIn on my OMAP3517 EVM, using 
AIC23 codec and McBSP1, and getting the following error:

arecord: pcm_read:1529: read error: Input/output error

Playback is working fine using the same combination. 

I have tried using another instance of AIC23 codec which uses McBSP2 
and both playback & capture works fine there.

Has anyone faced this issue before? Any suggestions?

Regards,
Anuj Aggarwal
