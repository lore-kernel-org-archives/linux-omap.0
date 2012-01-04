From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 02/10] i2c: OMAP: Add DT support for i2c controller
Date: Wed, 4 Jan 2012 14:56:17 -0700
Message-ID: <CACxGe6stVjLxpDrRpimqefPsyeGRAz3Gd1=myVvfzdupn7kvtQ@mail.gmail.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-3-git-send-email-b-cousson@ti.com> <87hb14q7vj.fsf@ti.com>
 <4F0455D8.7060904@ti.com> <87obujb1j2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87obujb1j2.fsf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 4, 2012 at 2:28 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org> writes:
>
>> Hi Kevin,
>>
>> On 12/14/2011 2:06 AM, Kevin Hilman wrote:
>>> Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org> =A0writes:
>>>
>>>> Add initial DT support to retrieve the frequency using a
>>>> DT attribute instead of the pdata pointer if of_node exist.
>>>>
>>>> Add documentation for omap i2c controller binding.
>>>>
>>>> Based on original patches from Manju and Grant.
>>>>
>>>> Signed-off-by: Benoit Cousson<b-cousson-l0cyMroinI0@public.gmane.org>
>>>> Cc: Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>>>
>>> This seems indepenent from the rest of the series, and I can queue up
>>> for merge via the I2C tree.
>>>
>>> Benoit, please confirm that we shouldn't have any problems if this patch
>>> goes independently.
>>>
>>> Grant/Rob, with your ack on the bindings, I can queue this up for the
>>> I2C maintainers along with some other OMAP I2C changes for v3.3.
>>
>> I removed the nasty bindings and got the Reviewed-by: from Rob for the
>> v4 [1].
>>
>> Could you take it in your branch? I've just tried merging your
>> for_3.3/i2c/misc on top of my for_3.3/3_omap_dt_i2c_twl branch and
>> tested it successfully on OMAP4 DT boot.
>
> Yes, I'll add v4 to my i2c/misc branch and add Grant's ack and queue.
>
> Note that Ben Dooks has not responded to any of my queries or pull
> requests, either for v3.2 fixes or for the v3.3 merge window, so
> unfortunately it doesn't look like this will make it for v3.3 unless Ben
> starts responding. =A0:(
>
> Kevin

Get it into linux-next anyway.  If Ben doesn't respond, then you can
ask Linus to pull directly near the end of the merge window.  I don't
see any benefit in making this sit out for another cycle.

g.



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
