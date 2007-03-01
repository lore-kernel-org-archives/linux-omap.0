From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] OMAP2 camera and TCM825x sensor drivers
Date: Thu, 1 Mar 2007 11:18:32 +0530
Message-ID: <5d5443650702282148n4fd5f586te9d0814875f6b59c@mail.gmail.com>
References: <45E5A489.2040108@nokia.com>
	<9C23CDD79DA20A479D4615857B2E2C475C9521@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C475C9521@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Syed,

On 2/28/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> If some patches are for review please mark them as "RFC". "Patch" is
> when it has to go into tree - Some one can correct me if I am wrong.
>
> Sakari,
>
> Thanks for the code, do you have any kind of design doc or ppt that
> gives a brief overview of what the code is and the interface considered
> etc. Its bit hard to go directly to code :(

I don't think that you will need this. What interface you would like
to understand? Please phrase the questions based on the code and may
Sakari can help you to understand :) I believe some of the changes in
N800 camera driver was also done to reduce the interrupt latencies and
bugs in video-buf.

>
> The second issue is merging TI's camera code with this. I can post our
> design considerations for camera. We can see how to integrate TIs sensor
> and additional functionality provided by TI's camera code (like
> rotation, scatter gather dma, multiple sensors handling etc).

Do you mean "rotation" of the preview window ? See, preview in camera
driver is just a add-on functionality _but_ not must. I would not use
this auto preview functionality, instead captured stream will go to
/dev/fb1 and then shown on the LCD/TV out and rotated based on the
N800 sensor or app commands.

-- 
--Trilok Soni
